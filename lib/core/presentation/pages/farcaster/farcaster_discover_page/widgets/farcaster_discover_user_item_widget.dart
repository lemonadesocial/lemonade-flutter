import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarcasterDiscoverUserItemWidget extends StatelessWidget {
  final AirstackFarcasterUser user;
  const FarcasterDiscoverUserItemWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LemonNetworkImage(
          width: Sizing.medium,
          height: Sizing.medium,
          imageUrl: user.profileImage ?? '',
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
                user.profileDisplayName ?? 'Anonymous',
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                '@${user.profileName}',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              if (user.profileBio?.isNotEmpty == true) ...[
                SizedBox(height: Spacing.xSmall),
                Text(
                  user.profileBio!,
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
