import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_channel.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';

class FarcasterChannelDetailBottomsheet extends StatefulWidget {
  final FarcasterChannel channel;
  const FarcasterChannelDetailBottomsheet({super.key, required this.channel});

  @override
  State<FarcasterChannelDetailBottomsheet> createState() =>
      _FarcasterChannelDetailBottomsheetState();
}

class _FarcasterChannelDetailBottomsheetState
    extends State<FarcasterChannelDetailBottomsheet> {
  Widget _buildHostsAvatars(
    List<Query$GetChannel$FarcasterChannels$FarcasterChannel$leadProfiles>
        hosts,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final maxHosts = hosts.take(3).toList();
    return SizedBox(
      width: (1 + 1 / 2 * (maxHosts.length - 1)) * Sizing.small,
      height: Sizing.small,
      child: Stack(
        children: maxHosts.asMap().entries.map((entry) {
          final maxHosts = entry.value;
          final position = entry.key;
          return Positioned(
            right: position * 12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizing.small),
              child: Container(
                width: Sizing.small,
                height: Sizing.small,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  border: Border.all(color: colorScheme.outline, width: 1.w),
                  borderRadius: BorderRadius.circular(Sizing.small),
                ),
                child: LemonNetworkImage(
                  width: Sizing.small,
                  height: Sizing.small,
                  imageUrl: maxHosts.profileImage ?? '',
                  placeholder: ImagePlaceholder.defaultPlaceholder(),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHostsNames(
    List<Query$GetChannel$FarcasterChannels$FarcasterChannel$leadProfiles>
        hosts,
  ) {
    final maxHosts = hosts.take(3).toList();
    final remainingHostsCount = hosts.length - maxHosts.length;
    final colorScheme = Theme.of(context).colorScheme;
    final names = maxHosts.map((host) => '@${host.profileName}').join(', ');
    return Text(
      '${t.farcaster.hostedBy} $names ${remainingHostsCount > 0 ? '+ $remainingHostsCount' : ''}',
      style: Typo.small.copyWith(
        color: colorScheme.onSecondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Query$GetChannel$Widget(
      options: Options$Query$GetChannel(
        variables: Variables$Query$GetChannel(
          channelId: widget.channel.id,
        ),
      ),
      builder: (result, {refetch, fetchMore}) {
        final t = Translations.of(context);
        final targetChannel =
            result.parsedData?.FarcasterChannels?.FarcasterChannel?.firstOrNull;
        final followersCount = targetChannel?.followerCount ?? 0;
        return Container(
          padding: EdgeInsets.all(Spacing.smMedium),
          color: LemonColor.atomicBlack,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    LemonNetworkImage(
                      width: 42.w,
                      height: 42.w,
                      imageUrl: widget.channel.imageUrl ?? '',
                      borderRadius: BorderRadius.circular(LemonRadius.xSmall),
                    ),
                    SizedBox(width: Spacing.xSmall),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.channel.name ?? '',
                          style: Typo.extraMedium.copyWith(
                            color: LemonColor.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '/${widget.channel.id}',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (widget.channel.description?.isNotEmpty == true) ...[
                  SizedBox(height: Spacing.xSmall),
                  Linkify(
                    text: widget.channel.description ?? '',
                    linkStyle: Typo.medium.copyWith(
                      color: LemonColor.paleViolet,
                      decoration: TextDecoration.none,
                    ),
                    style: Typo.medium.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      decoration: TextDecoration.none,
                    ),
                    onOpen: (link) {
                      launchUrl(Uri.parse(link.url));
                    },
                  ),
                ],
                SizedBox(height: Spacing.xSmall),
                if (result.isLoading)
                  Center(
                    child: Loading.defaultLoading(context),
                  ),
                if (!result.isLoading) ...[
                  if (targetChannel?.leadProfiles?.isNotEmpty == true) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHostsAvatars(targetChannel?.leadProfiles ?? []),
                        SizedBox(width: Spacing.xSmall),
                        ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) => Assets.icons.icHostFilled.svg(
                            colorFilter: filter,
                            width: 15.w,
                            height: 15.w,
                          ),
                        ),
                        SizedBox(width: Spacing.superExtraSmall),
                        Flexible(
                          child: _buildHostsNames(
                            targetChannel?.leadProfiles ?? [],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.xSmall),
                  ],
                  Row(
                    children: [
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icProfile.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        '${NumberFormat.compact().format(followersCount)} ${t.farcaster.members(n: followersCount)}',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
