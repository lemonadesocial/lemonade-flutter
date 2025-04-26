import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lenst_post_feed_item_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/graphql/lens/post/query/lens_fetch_posts.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LensPostFeedWidget extends StatefulWidget {
  const LensPostFeedWidget({super.key});

  @override
  State<LensPostFeedWidget> createState() => _LensPostFeedWidgetState();
}

class _LensPostFeedWidgetState extends State<LensPostFeedWidget> {
  String? cursor;
  late final Input$PostsRequest queryInput;
  final debouncer = Debouncer(milliseconds: 300);

  _LensPostFeedWidgetState() {
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
            // TODO: Lens: passd feed id here
            // feed: "0x7A305Fb4CEDd23979A6aC13d76C8A971DCf8C115",
            globalFeed: true,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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

          if (result.isLoading && posts.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(
                child: Loading.defaultLoading(context),
              ),
            );
          }

          if (posts.isEmpty || result.hasException) {
            return const SliverToBoxAdapter(
              child: EmptyList(),
            );
          }

          return BlocListener<ScrollNotificationBloc, ScrollNotificationState>(
            listener: (context, state) {
              if (state is ScrollNotificationStateEndReached) {
                if (result.isLoading || cursor == null) {
                  return;
                }

                final fetchMoreOptions = FetchMoreOptions$Query$LensFetchPosts(
                  variables: Variables$Query$LensFetchPosts(
                    request: queryInput.copyWith(
                      cursor: cursor,
                    ),
                  ),
                  updateQuery: (prevResult, nextResult) {
                    final prevList =
                        prevResult?['posts']['items'] as List<dynamic>? ?? [];
                    final nextList =
                        nextResult?['posts']['items'] as List<dynamic>? ?? [];
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
                      return Loading.defaultLoading(context);
                    }
                    return const SizedBox.shrink();
                  }
                  return LensPostFeedItemWidget(
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
          );
        },
      ),
    );
  }
}
