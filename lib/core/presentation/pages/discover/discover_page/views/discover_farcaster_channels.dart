import 'package:app/core/config.dart';
import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/widgets/airstack_gql_provider_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_channels.graphql.dart';
import 'package:app/graphql/farcaster_airstack/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
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
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return MultiSliver(
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(const FarcasterDiscoverRoute());
              },
              child: Row(
                children: [
                  Text(
                    t.farcaster.discover.discoverTabs.channels,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: Spacing.extraSmall),
                  ThemeSvgIcon(
                    builder: (filter) => Assets.icons.icArrowRight.svg(
                      color: colorScheme.onSecondary,
                      width: Sizing.mSmall,
                      height: Sizing.mSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
                  height: 124.w,
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
      width: 96.w,
      child: Column(
        children: [
          Container(
            height: 96.w,
            width: 96.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: LemonColor.paleViolet,
                width: 2.w,
              ),
              borderRadius: BorderRadius.circular(96.w),
            ),
            child: Center(
              child: LemonNetworkImage(
                width: 88.w,
                height: 88.w,
                borderRadius: BorderRadius.circular(88.w),
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
