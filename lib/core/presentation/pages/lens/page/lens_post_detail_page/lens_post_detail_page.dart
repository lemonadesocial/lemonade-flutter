import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/core/presentation/pages/lens/widget/create_lens_post_result_listener_widget/create_lens_post_result_listener_widget.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lenst_post_feed_item_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/lens/post/query/lens_fetch_post_references.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:app/core/utils/debouncer.dart';

@RoutePage()
class LensPostDetailPage extends StatefulWidget {
  final LensPost post;
  const LensPostDetailPage({
    super.key,
    required this.post,
  });

  @override
  State<LensPostDetailPage> createState() => _LensPostDetailPageState();
}

class _LensPostDetailPageState extends State<LensPostDetailPage> {
  final debouncer = Debouncer(milliseconds: 300);
  final _refreshController = RefreshController();
  late final Input$PostReferencesRequest input;
  String? cursor;

  @override
  void initState() {
    input = Input$PostReferencesRequest(
      referencedPost: widget.post.id ?? '',
      referenceTypes: [Enum$PostReferenceType.COMMENT_ON],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.farcaster.conversation,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.bgChat.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: GraphQLProvider(
          client: ValueNotifier(getIt<LensGQL>().client),
          child: Query$LensFetchPostReferences$Widget(
            options: Options$Query$LensFetchPostReferences(
              fetchPolicy: FetchPolicy.cacheFirst,
              variables: Variables$Query$LensFetchPostReferences(
                request: input,
              ),
              onComplete: (_, data) {
                _refreshController.refreshCompleted();
                cursor = data?.postReferences.pageInfo.next;
              },
            ),
            builder: (
              result, {
              refetch,
              fetchMore,
            }) {
              final posts = (result.parsedData?.postReferences.items ?? [])
                  .map(
                    (item) => LensPost.fromJson(
                      item.toJson(),
                    ),
                  )
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
                          FetchMoreOptions$Query$LensFetchPostReferences(
                        variables: Variables$Query$LensFetchPostReferences(
                          request: input.copyWith(
                            cursor: cursor,
                          ),
                        ),
                        updateQuery: (prevResult, nextResult) {
                          final prevList = prevResult?['postReferences']
                                  ?['items'] as List<dynamic>? ??
                              [];
                          final nextList = nextResult?['postReferences']
                                  ?['items'] as List<dynamic>? ??
                              [];
                          final newList = [...prevList, ...nextList];
                          nextResult?['postReferences']['items'] = newList;
                          return nextResult;
                        },
                      );
                      debouncer.run(
                        () => fetchMore?.call(fetchMoreOptions),
                      );
                    }
                  }
                  return true;
                },
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () async {
                    refetch?.call();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: CreateLensPostResultListenerWidget(
                          onSuccess: () {
                            refetch?.call();
                          },
                          onError: () {
                            // TODO: Handle error
                          },
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.xSmall,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: LensPostFeedItemWidget(
                            post: widget.post,
                            showActions: true,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Divider(
                          color: colorScheme.outline,
                        ),
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
      ),
    );
  }
}
