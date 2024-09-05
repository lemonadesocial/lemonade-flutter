import 'package:app/core/config.dart';
import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/gql/widgets/airstack_gql_provider_widget.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_channels.graphql.dart';
import 'package:app/graphql/farcaster_airstack/schema.graphql.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DiscoverFarcasterChannels extends StatefulWidget {
  const DiscoverFarcasterChannels({super.key});

  @override
  State<DiscoverFarcasterChannels> createState() =>
      _DiscoverFarcasterChannelsState();
}

class _DiscoverFarcasterChannelsState extends State<DiscoverFarcasterChannels> {
  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.xSmall,
          ),
        ),
        AirstackGQLProviderWidget(
          child: Query$GetFarcasterChannels$Widget(
            options: Options$Query$GetFarcasterChannels(
              variables: Variables$Query$GetFarcasterChannels(
                filter: Input$FarcasterChannelFilter(
                  channelId: Input$String_Comparator_Exp(
                    $_in: AppConfig.farcasterDefaultChannels,
                  ),
                ),
              ),
            ),
            builder: (
              result, {
              refetch,
              fetchMore,
            }) {
              final channels =
                  (result.parsedData?.FarcasterChannels?.FarcasterChannel ?? [])
                      .map(
                        (item) => AirstackFarcasterChannel.fromJson(
                          item.toJson(),
                        ),
                      )
                      .toList();
              if (result.isLoading) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 124.w,
                    child: Center(
                      child: Loading.defaultLoading(context),
                    ),
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: 88.w,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          AutoRouter.of(context).push(
                            FarcasterChannelNewsfeedRoute(
                              channel: FarcasterChannel.fromJson(
                                channels[index].toJson(),
                              ).copyWith(
                                id: channels[index].channelId,
                              ),
                            ),
                          );
                        },
                        child: _ChannelItem(
                          channel: channels[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      width: Spacing.small,
                    ),
                    itemCount: channels.length,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ChannelItem extends StatelessWidget {
  final AirstackFarcasterChannel channel;
  const _ChannelItem({
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62.w,
      child: Column(
        children: [
          Container(
            height: 62.w,
            width: 62.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: LemonColor.paleViolet,
                width: 2.w,
              ),
              borderRadius: BorderRadius.circular(96.w),
            ),
            child: Center(
              child: LemonNetworkImage(
                width: 55.w,
                height: 55.w,
                borderRadius: BorderRadius.circular(55.w),
                imageUrl: channel.imageUrl ?? '',
                placeholder: ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
          ),
          SizedBox(
            height: Spacing.xSmall,
          ),
          Text(
            channel.name ?? '',
            style: Typo.small.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
