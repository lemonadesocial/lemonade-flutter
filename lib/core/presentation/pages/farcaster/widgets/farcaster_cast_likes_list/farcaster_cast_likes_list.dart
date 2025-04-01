import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/farcaster_user_item_widget/farcaster_user_item_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_cast_likes.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:app/core/utils/debouncer.dart';

class FarcasterCastLikesList extends StatefulWidget {
  final AirstackFarcasterCast cast;
  const FarcasterCastLikesList({
    super.key,
    required this.cast,
  });

  @override
  State<FarcasterCastLikesList> createState() => _FarcasterCastLikesListState();
}

class _FarcasterCastLikesListState extends State<FarcasterCastLikesList> {
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
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: LemonColor.atomicBlack,
      appBar: LemonAppBar(
        title: StringUtils.capitalize(t.farcaster.like(n: 2)),
        backgroundColor: LemonColor.atomicBlack,
      ),
      body: Builder(
        builder: (context) => GraphQLProvider(
          client: airstackClient,
          child: Query$GetFarcasterCastLikes$Widget(
            options: Options$Query$GetFarcasterCastLikes(
              fetchPolicy: FetchPolicy.cacheFirst,
              variables: Variables$Query$GetFarcasterCastLikes(
                castHash: widget.cast.hash,
              ),
              onComplete: (_, __) {
                _refreshController.refreshCompleted();
              },
            ),
            builder: (result, {refetch, fetchMore}) {
              final farcasterUsers =
                  (result.parsedData?.FarcasterReactions?.Reaction ?? [])
                      .map(
                        (item) => item.reactedBy != null
                            ? AirstackFarcasterUser.fromJson(
                                item.reactedBy!.toJson(),
                              )
                            : null,
                      )
                      .whereType<AirstackFarcasterUser>()
                      .toList();

              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    if (notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                      final pageInfo =
                          result.parsedData?.FarcasterReactions?.pageInfo;
                      if (result.isLoading || pageInfo?.hasNextPage == false) {
                        return true;
                      }

                      final fetchMoreOptions =
                          FetchMoreOptions$Query$GetFarcasterCastLikes(
                        variables: Variables$Query$GetFarcasterCastLikes(
                          castHash: widget.cast.hash,
                          cursor: pageInfo?.nextCursor,
                        ),
                        updateQuery: (prevResult, nextResult) {
                          final prevList = prevResult?['FarcasterReactions']
                                  ?['Reaction'] as List<dynamic>? ??
                              [];
                          final nextList = nextResult?['FarcasterReactions']
                                  ?['Reaction'] as List<dynamic>? ??
                              [];
                          final newList = [...prevList, ...nextList];
                          nextResult?['FarcasterReactions']['Reaction'] =
                              newList;
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
                      if (result.isLoading && farcasterUsers.isEmpty)
                        SliverToBoxAdapter(
                          child: Loading.defaultLoading(context),
                        ),
                      if (result.isNotLoading && farcasterUsers.isEmpty)
                        const SliverToBoxAdapter(
                          child: EmptyList(),
                        ),
                      SliverList.separated(
                        itemCount: farcasterUsers.length + 1,
                        separatorBuilder: (context, index) => Divider(
                          color: colorScheme.outline,
                        ),
                        itemBuilder: (context, index) {
                          if (index == farcasterUsers.length) {
                            if (result.parsedData?.FarcasterReactions?.pageInfo
                                    ?.hasNextPage !=
                                true) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Spacing.medium,
                              ),
                              child: Loading.defaultLoading(context),
                            );
                          }
                          final user = farcasterUsers[index];
                          return InkWell(
                            onTap: () => AutoRouter.of(context).push(
                              FarcasterUserProfileRoute(
                                profileName: user.profileName ?? '',
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Spacing.xSmall,
                                vertical: Spacing.xSmall,
                              ),
                              child: FarcasterUserItemWidget(
                                key: ValueKey(
                                  user.fid,
                                ),
                                user: user,
                              ),
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
