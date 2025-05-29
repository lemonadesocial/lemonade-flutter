import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lenst_post_feed_item_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/lens/post/query/lens_fetch_posts.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/core/utils/debouncer.dart';

class LensAccountProfileNewsfeed extends StatefulWidget {
  final LensAccount lensAccount;
  const LensAccountProfileNewsfeed({
    super.key,
    required this.lensAccount,
  });

  @override
  State<LensAccountProfileNewsfeed> createState() =>
      _LensAccountProfileNewsfeedState();
}

class _LensAccountProfileNewsfeedState
    extends State<LensAccountProfileNewsfeed> {
  late ValueNotifier<GraphQLClient> airstackClient;
  final debouncer = Debouncer(milliseconds: 300);
  late final Input$PostsRequest queryInput;
  String? cursor;

  @override
  void initState() {
    super.initState();
    queryInput = Input$PostsRequest(
      filter: Input$PostsFilter(
        metadata: Input$PostMetadataFilter(
          mainContentFocus: [
            Enum$MainContentFocus.TEXT_ONLY,
            Enum$MainContentFocus.IMAGE,
            Enum$MainContentFocus.EVENT,
          ],
        ),
        authors: [
          widget.lensAccount.address ?? '',
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Builder(
      builder: (context) => GraphQLProvider(
        client: ValueNotifier(getIt<LensGQL>().client),
        child: Query$LensFetchPosts$Widget(
          options: Options$Query$LensFetchPosts(
            fetchPolicy: FetchPolicy.cacheFirst,
            variables: Variables$Query$LensFetchPosts(
              request: Input$PostsRequest(
                filter: Input$PostsFilter(
                  authors: [
                    widget.lensAccount.address ?? '',
                  ],
                ),
              ),
            ),
            onComplete: (raw, result) {
              cursor = result?.posts.pageInfo.next;
              // _refreshController.refreshCompleted();
            },
          ),
          builder: (result, {refetch, fetchMore}) {
            final posts = (result.parsedData?.posts.items ?? [])
                .map(
                  (item) => LensPost.fromJson(
                    item.toJson(),
                  ),
                )
                .where((post) => post.id?.isNotEmpty == true)
                .toList();

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    if (result.isLoading || cursor == null) {
                      return true;
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
                    debouncer.run(() => fetchMore?.call(fetchMoreOptions));
                  }
                }
                return true;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  refetch?.call();
                },
                child: CustomScrollView(
                  slivers: [
                    if (result.isNotLoading && posts.isEmpty)
                      const SliverToBoxAdapter(
                        child: EmptyList(),
                      ),
                    if (result.isLoading && posts.isEmpty)
                      SliverToBoxAdapter(
                        child: Loading.defaultLoading(context),
                      ),
                    SliverList.separated(
                      itemCount: posts.length,
                      separatorBuilder: (context, index) => Divider(
                        color: colorScheme.outline,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.xSmall,
                          ),
                          child: LensPostFeedItemWidget(
                            key: ValueKey(posts[index].id),
                            post: posts[index],
                            showActions: true,
                            onTap: () {
                              AutoRouter.of(context).push(
                                LensPostDetailRoute(
                                  post: posts[index],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
