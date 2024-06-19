import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:app/core/presentation/pages/farcaster/farcaster_discover_page/widgets/facaster_discover_channels_item_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/gql/widgets/airstack_gql_provider_widget.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_channels.graphql.dart';
import 'package:app/graphql/farcaster_airstack/schema.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class FarcasterDiscoverChannelsTab extends StatefulWidget {
  final TextEditingController textController;

  const FarcasterDiscoverChannelsTab({
    super.key,
    required this.textController,
  });

  @override
  State<FarcasterDiscoverChannelsTab> createState() =>
      _FarcasterDiscoverChannelsTabState();
}

class _FarcasterDiscoverChannelsTabState
    extends State<FarcasterDiscoverChannelsTab> {
  final debouncer = Debouncer(milliseconds: 300);
  final _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => AirstackGQLProviderWidget(
        child: Query$GetFarcasterChannels$Widget(
          options: Options$Query$GetFarcasterChannels(
            variables: Variables$Query$GetFarcasterChannels(
              filter: Input$FarcasterChannelFilter(),
            ),
            onComplete: (_, __) {
              _refreshController.refreshCompleted();
            },
          ),
          builder: (result, {refetch, fetchMore}) {
            return _ChannelsListView(
              textController: widget.textController,
              refreshController: _refreshController,
              debouncer: debouncer,
              result: result,
              refetch: refetch,
              fetchMore: fetchMore,
            );
          },
        ),
      ),
    );
  }
}

class _ChannelsListView extends StatefulWidget {
  const _ChannelsListView({
    required this.textController,
    required this.refreshController,
    required this.debouncer,
    required this.result,
    required this.refetch,
    required this.fetchMore,
  });

  final TextEditingController textController;
  final Debouncer debouncer;
  final RefreshController refreshController;
  final QueryResult<Query$GetFarcasterChannels> result;
  final Future<QueryResult<Query$GetFarcasterChannels>?> Function()? refetch;
  final Future<QueryResult<Query$GetFarcasterChannels>> Function(
    FetchMoreOptions,
  )? fetchMore;

  @override
  State<_ChannelsListView> createState() => _ChannelsListViewState();
}

class _ChannelsListViewState extends State<_ChannelsListView> {
  @override
  void initState() {
    super.initState();
    widget.textController.addListener(() {
      widget.debouncer.run(() {
        if (widget.textController.text.isEmpty) {
          widget.fetchMore?.call(
            FetchMoreOptions$Query$GetFarcasterChannels(
              variables: Variables$Query$GetFarcasterChannels(
                filter: Input$FarcasterChannelFilter(),
              ),
              updateQuery: (prev, next) => next,
            ),
          );
          return;
        }
        widget.fetchMore?.call(
          FetchMoreOptions$Query$GetFarcasterChannels(
            variables: Variables$Query$GetFarcasterChannels(
              limit: 50,
              filter: Input$FarcasterChannelFilter(
                name: Input$Regex_String_Comparator_Exp(
                  $_regex: "^${widget.textController.text}",
                ),
              ),
            ),
            updateQuery: (prev, next) => next,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final channels =
        (widget.result.parsedData?.FarcasterChannels?.FarcasterChannel ?? [])
            .map(
              (item) => AirstackFarcasterChannel.fromJson(
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
                widget.result.parsedData?.FarcasterChannels?.pageInfo;
            if (widget.result.isLoading || pageInfo?.hasNextPage == false) {
              return true;
            }

            final fetchMoreOptions =
                FetchMoreOptions$Query$GetFarcasterChannels(
              variables: Variables$Query$GetFarcasterChannels(
                filter: Input$FarcasterChannelFilter(),
                cursor: pageInfo?.nextCursor,
              ),
              updateQuery: (prevResult, nextResult) {
                final prevList = prevResult?['FarcasterChannels']
                        ?['FarcasterChannel'] as List<dynamic>? ??
                    [];
                final nextList = nextResult?['FarcasterChannels']
                        ?['FarcasterChannel'] as List<dynamic>? ??
                    [];
                final newList = [...prevList, ...nextList];
                nextResult?['FarcasterChannels']['FarcasterChannel'] = newList;
                return nextResult;
              },
            );
            widget.debouncer.run(
              () => widget.fetchMore?.call(fetchMoreOptions),
            );
          }
        }
        return true;
      },
      child: SmartRefresher(
        controller: widget.refreshController,
        onRefresh: () async {
          widget.refetch?.call();
        },
        child: CustomScrollView(
          slivers: [
            if (widget.result.isLoading && channels.isEmpty)
              SliverToBoxAdapter(
                child: Loading.defaultLoading(context),
              ),
            if (widget.result.isNotLoading && channels.isEmpty)
              const SliverToBoxAdapter(
                child: EmptyList(),
              ),
            SliverList.separated(
              itemCount: channels.length + 1,
              separatorBuilder: (context, index) => Divider(
                color: colorScheme.outline,
              ),
              itemBuilder: (context, index) {
                if (index == channels.length) {
                  if (widget.result.parsedData?.FarcasterChannels?.pageInfo
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
                final channel = channels[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.xSmall,
                    vertical: Spacing.xSmall,
                  ),
                  child: InkWell(
                    onTap: () {
                      AutoRouter.of(context).push(
                        FarcasterChannelNewsfeedRoute(
                          channel: FarcasterChannel.fromJson(
                            channel.toJson(),
                          ).copyWith(
                            id: channel.channelId,
                          ),
                        ),
                      );
                    },
                    child: FarcasterDiscoverChannelItemWidget(
                      key: ValueKey(channels[index].channelId),
                      channel: channels[index],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
