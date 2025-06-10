import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/application/lens/lens_auth_bloc/lens_auth_bloc.dart';
import 'package:app/core/presentation/pages/lens/widget/create_lens_post_result_listener_widget/create_lens_post_result_listener_widget.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lens_empty_list_widget.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lenst_post_feed_item_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/graphql/lens/post/query/lens_fetch_posts.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:app/app_theme/app_theme.dart';

class LensPostFeedWidget extends StatefulWidget {
  const LensPostFeedWidget({
    super.key,
    this.title,
    this.lensFeedId,
  });

  final String? title;
  final String? lensFeedId;

  @override
  State<LensPostFeedWidget> createState() => _LensPostFeedWidgetState();
}

class _LensPostFeedWidgetState extends State<LensPostFeedWidget> {
  String? cursor;
  late Input$PostsRequest queryInput;
  final debouncer = Debouncer(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    queryInput = LensUtils.getDefaultFeedQueryInput(
      lensFeedId: widget.lensFeedId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return BlocBuilder<LensAuthBloc, LensAuthState>(
      builder: (context, lensAuthState) {
        if (widget.lensFeedId == null) {
          return MultiSliver(
            children: [
              const SliverToBoxAdapter(
                child: LensEmptyListWidget(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: Spacing.s18),
              ),
            ],
          );
        }

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
                  .where((post) => post.id?.isNotEmpty == true)
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
                        child: Loading.defaultLoading(
                          context,
                        ),
                      ),
                    )
                  else if (posts.isEmpty || result.hasException)
                    const SliverToBoxAdapter(
                      child: LensEmptyListWidget(),
                    )
                  else ...[
                    if (widget.title != null)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.s4,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: Spacing.s5),
                              Text(
                                widget.title!,
                                style: context.theme.appTextTheme.lg,
                              ),
                              SizedBox(height: Spacing.s4),
                            ],
                          ),
                        ),
                      ),
                    BlocListener<ScrollNotificationBloc,
                        ScrollNotificationState>(
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
                              final prevList = prevResult?['posts']['items']
                                      as List<dynamic>? ??
                                  [];
                              final nextList = nextResult?['posts']['items']
                                      as List<dynamic>? ??
                                  [];
                              final newList = [...prevList, ...nextList];
                              nextResult?['posts']['items'] = newList;
                              return nextResult;
                            },
                          );
                          debouncer
                              .run(() => fetchMore?.call(fetchMoreOptions));
                        }
                      },
                      child: SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.s4,
                        ),
                        sliver: SliverList.separated(
                          itemCount: posts.length + 1,
                          itemBuilder: (context, index) {
                            if (index == posts.length) {
                              if (result.isLoading) {
                                return Loading.defaultLoading(context);
                              }
                              return const SizedBox.shrink();
                            }
                            return LensPostFeedItemWidget(
                              post: posts[index],
                              showActions: true,
                              onTap: () async {
                                await AutoRouter.of(context).push(
                                  LensPostDetailRoute(
                                    post: posts[index],
                                  ),
                                );
                                refetch?.call();
                              },
                              onRefresh: () {
                                refetch?.call();
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                              height: 16,
                              color: appColors.pageDivider,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }
}
