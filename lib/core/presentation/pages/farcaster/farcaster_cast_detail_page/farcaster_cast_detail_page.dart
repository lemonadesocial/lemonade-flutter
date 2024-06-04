import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/farcaster_cast_item_widget/farcaster_cast_item_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_cast_replies.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:web3modal_flutter/utils/debouncer.dart';

@RoutePage()
class FarcasterCastDetailPage extends StatefulWidget {
  final AirstackFarcasterCast cast;
  const FarcasterCastDetailPage({
    super.key,
    required this.cast,
  });

  @override
  State<FarcasterCastDetailPage> createState() =>
      _FarcasterCastDetailPageState();
}

class _FarcasterCastDetailPageState extends State<FarcasterCastDetailPage> {
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
          client: airstackClient,
          child: Query$GetFarcasterCastReplies$Widget(
            options: Options$Query$GetFarcasterCastReplies(
              fetchPolicy: FetchPolicy.cacheFirst,
              variables: Variables$Query$GetFarcasterCastReplies(
                castHash: widget.cast.hash,
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
                          FetchMoreOptions$Query$GetFarcasterCastReplies(
                        variables: Variables$Query$GetFarcasterCastReplies(
                          castHash: widget.cast.hash,
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
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.xSmall,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: FarcasterCastItemWidget(
                            cast: widget.cast,
                            showActions: true,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Divider(
                          color: colorScheme.outline,
                        ),
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
      ),
    );
  }
}
