import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/farcaster_cast_item_widget/farcaster_cast_item_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/farcaster_airstack/query/get_user_farcaster_casts.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:web3modal_flutter/utils/debouncer.dart';

class UserFarcasterCastsNewsfeed extends StatefulWidget {
  final AirstackFarcasterUser user;
  const UserFarcasterCastsNewsfeed({
    super.key,
    required this.user,
  });

  @override
  State<UserFarcasterCastsNewsfeed> createState() =>
      _UserFarcasterCastsNewsfeedState();
}

class _UserFarcasterCastsNewsfeedState
    extends State<UserFarcasterCastsNewsfeed> {
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
        child: Query$GetUserFarcasterCasts$Widget(
          options: Options$Query$GetUserFarcasterCasts(
            fetchPolicy: FetchPolicy.cacheFirst,
            variables: Variables$Query$GetUserFarcasterCasts(
              fc_fname: "fc_fname:${widget.user.profileName}",
            ),
            onComplete: (_, __) {
              _refreshController.refreshCompleted();
            },
          ),
          builder: (result, {refetch, fetchMore}) {
            final casts = (result.parsedData?.FarcasterCasts?.Cast ?? [])
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
                        result.parsedData?.FarcasterCasts?.pageInfo;
                    if (result.isLoading || pageInfo?.hasNextPage == false) {
                      return true;
                    }

                    final fetchMoreOptions =
                        FetchMoreOptions$Query$GetUserFarcasterCasts(
                      variables: Variables$Query$GetUserFarcasterCasts(
                        fc_fname: "fc_fname:${widget.user.profileName}",
                        cursor: pageInfo?.nextCursor,
                      ),
                      updateQuery: (prevResult, nextResult) {
                        final prevList = prevResult?['FarcasterCasts']?['Cast']
                                as List<dynamic>? ??
                            [];
                        final nextList = nextResult?['FarcasterCasts']?['Cast']
                                as List<dynamic>? ??
                            [];
                        final newList = [...prevList, ...nextList];
                        nextResult?['FarcasterCasts']['Cast'] = newList;
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
                    if (result.isNotLoading && casts.isEmpty)
                      const SliverToBoxAdapter(
                        child: EmptyList(),
                      ),
                    if (result.isLoading && casts.isEmpty)
                      SliverToBoxAdapter(
                        child: Loading.defaultLoading(context),
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
