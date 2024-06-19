import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarcasterDiscoverChannelItemWidget extends StatelessWidget {
  final AirstackFarcasterChannel channel;
  const FarcasterDiscoverChannelItemWidget({
    super.key,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LemonNetworkImage(
          width: Sizing.medium,
          height: Sizing.medium,
          imageUrl: channel.imageUrl ?? '',
          borderRadius: BorderRadius.circular(Sizing.medium),
          placeholder: ImagePlaceholder.avatarPlaceholder(),
        ),
        SizedBox(
          width: Spacing.xSmall,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                channel.name ?? t.common.anonymous,
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                '/${channel.channelId}',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              if (channel.description?.isNotEmpty == true) ...[
                SizedBox(height: Spacing.xSmall),
                Text(
                  channel.description!,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
