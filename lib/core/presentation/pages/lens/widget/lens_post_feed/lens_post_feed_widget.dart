import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/presentation/pages/lens/widget/create_lens_post_result_listener_widget/create_lens_post_result_listener_widget.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lenst_post_feed_item_widget.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/create_lens_new_feed_bottomsheet.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/graphql/lens/post/query/lens_fetch_posts.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:app/core/domain/space/entities/space.dart';

class LensPostFeedWidget extends StatefulWidget {
  const LensPostFeedWidget({super.key, required this.space});

  final Space space;

  @override
  State<LensPostFeedWidget> createState() => _LensPostFeedWidgetState();
}

class _LensPostFeedWidgetState extends State<LensPostFeedWidget> {
  String? cursor;
  late final Input$PostsRequest queryInput;
  final debouncer = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final spaceLensFeedId = widget.space.lensFeedId;
    final t = Translations.of(context);

    if (spaceLensFeedId == null) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(Spacing.medium),
          child: LinearGradientButton.primaryButton(
            onTap: () {
              showCupertinoModalBottomSheet(
                context: context,
                backgroundColor: LemonColor.atomicBlack,
                topRadius: Radius.circular(30.r),
                builder: (mContext) {
                  return CreateLensNewFeedBottomSheet(
                    space: widget.space,
                  );
                },
              );
            },
            label: t.space.lens.createNewFeed,
          ),
        ),
      );
    }

    queryInput = Input$PostsRequest(
      cursor: null,
      filter: Input$PostsFilter(
        postTypes: [Enum$PostType.ROOT, Enum$PostType.REPOST],
        metadata: Input$PostMetadataFilter(
          mainContentFocus: [
            Enum$MainContentFocus.TEXT_ONLY,
            Enum$MainContentFocus.IMAGE,
            Enum$MainContentFocus.EVENT,
          ],
        ),
        feeds: [
          Input$FeedOneOf(
            feed: spaceLensFeedId,
            globalFeed: true,
          ),
        ],
      ),
    );

    return GraphQLProvider(
      client: ValueNotifier(getIt<LensGQL>().client),
      child: Query$LensFetchPosts$Widget(
        options: Options$Query$LensFetchPosts(
          fetchPolicy: FetchPolicy.networkOnly,
          onComplete: (raw, result) {
            cursor = result?.posts.pageInfo.next;
          },
          variables: Variables$Query$LensFetchPosts(
            request: queryInput,
          ),
        ),
        builder: (
          result, {
          refetch,
          fetchMore,
        }) {
          final posts = (result.parsedData?.posts.items ?? [])
              .map(
                (item) => LensPost.fromJson(
                  item.toJson(),
                ),
              )
              .toList();

          return MultiSliver(
            children: [
              CreateLensPostResultListenerWidget(
                onSuccess: () {
                  refetch?.call();
                },
                onError: () {
                  // TODO: Handle error
                },
              ),
              if (result.isLoading && posts.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Loading.defaultLoading(context),
                  ),
                )
              else if (posts.isEmpty || result.hasException)
                const SliverToBoxAdapter(
                  child: EmptyList(),
                )
              else
                BlocListener<ScrollNotificationBloc, ScrollNotificationState>(
                  listener: (context, state) {
                    if (state is ScrollNotificationStateEndReached) {
                      if (result.isLoading || cursor == null) {
                        return;
                      }

                      final fetchMoreOptions =
                          FetchMoreOptions$Query$LensFetchPosts(
                        variables: Variables$Query$LensFetchPosts(
                          request: queryInput.copyWith(
                            cursor: cursor,
                          ),
                        ),
                        updateQuery: (prevResult, nextResult) {
                          final prevList =
                              prevResult?['posts']['items'] as List<dynamic>? ??
                                  [];
                          final nextList =
                              nextResult?['posts']['items'] as List<dynamic>? ??
                                  [];
                          final newList = [...prevList, ...nextList];
                          nextResult?['posts']['items'] = newList;
                          return nextResult;
                        },
                      );
                      debouncer.run(
                        () => fetchMore?.call(fetchMoreOptions),
                      );
                    }
                  },
                  child: SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                    sliver: SliverList.separated(
                      itemCount: posts.length + 1,
                      itemBuilder: (context, index) {
                        if (index == posts.length) {
                          if (result.isLoading) {
                            return SafeArea(
                              child: Loading.defaultLoading(context),
                            );
                          }
                          return const SizedBox.shrink();
                        }
                        return LensPostFeedItemWidget(
                          onTap: () {
                            AutoRouter.of(context).push(
                              LensPostDetailRoute(
                                post: posts[index],
                              ),
                            );
                          },
                          post: posts[index],
                          showActions: true,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1,
                          height: 16,
                          color: colorScheme.outline,
                        );
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
