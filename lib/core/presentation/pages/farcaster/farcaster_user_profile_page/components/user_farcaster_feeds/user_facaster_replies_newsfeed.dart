import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/farcaster_cast_item_widget/farcaster_cast_item_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/farcaster_airstack/query/get_user_farcaster_replies.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:app/core/utils/debouncer.dart';

class UserFarcasterRepliesNewsfeed extends StatefulWidget {
  final AirstackFarcasterUser user;
  const UserFarcasterRepliesNewsfeed({
    super.key,
    required this.user,
  });

  @override
  State<UserFarcasterRepliesNewsfeed> createState() =>
      _UserFarcasterRepliesNewsfeedState();
}

class _UserFarcasterRepliesNewsfeedState
    extends State<UserFarcasterRepliesNewsfeed> {
  late ValueNotifier<GraphQLClient> airstackClient;
  final debouncer = Debouncer(milliseconds: 300);
  final _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    airstackClient = ValueNotifier(getIt<AirstackGQL>().client);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Builder(
      builder: (context) => GraphQLProvider(
        client: airstackClient,
        child: Query$GetUserFarcasterReplies$Widget(
          options: Options$Query$GetUserFarcasterReplies(
            fetchPolicy: FetchPolicy.cacheFirst,
            variables: Variables$Query$GetUserFarcasterReplies(
              fc_fid: "fc_fid:${widget.user.fid}",
            ),
            onComplete: (_, __) {
              _refreshController.refreshCompleted();
            },
          ),
          builder: (result, {refetch, fetchMore}) {
            final casts = (result.parsedData?.FarcasterReplies?.Reply ?? [])
                .map(
                  (item) => AirstackFarcasterCast.fromJson(
                    item.toJson(),
                  ),
                )
                .toList();

            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    final pageInfo =
                        result.parsedData?.FarcasterReplies?.pageInfo;
                    if (result.isLoading || pageInfo?.hasNextPage == false) {
                      return true;
                    }

                    final fetchMoreOptions =
                        FetchMoreOptions$Query$GetUserFarcasterReplies(
                      variables: Variables$Query$GetUserFarcasterReplies(
                        fc_fid: "fc_fid:${widget.user.fid}",
                        cursor: pageInfo?.nextCursor,
                      ),
                      updateQuery: (prevResult, nextResult) {
                        final prevList = prevResult?['FarcasterReplies']
                                ?['Reply'] as List<dynamic>? ??
                            [];
                        final nextList = nextResult?['FarcasterReplies']
                                ?['Reply'] as List<dynamic>? ??
                            [];
                        final newList = [...prevList, ...nextList];
                        nextResult?['FarcasterReplies']['Reply'] = newList;
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
                      child: SizedBox(
                        height: 1.5 * Spacing.xLarge,
                      ),
                    ),
                    if (result.isLoading && casts.isEmpty)
                      SliverToBoxAdapter(
                        child: Loading.defaultLoading(context),
                      ),
                    if (result.isNotLoading && casts.isEmpty)
                      const SliverToBoxAdapter(
                        child: EmptyList(),
                      ),
                    SliverList.separated(
                      itemCount: casts.length,
                      separatorBuilder: (context, index) => Divider(
                        color: colorScheme.outline,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.xSmall,
                          ),
                          child: FarcasterCastItemWidget(
                            key: ValueKey(casts[index].id),
                            cast: casts[index],
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
    );
  }
}
