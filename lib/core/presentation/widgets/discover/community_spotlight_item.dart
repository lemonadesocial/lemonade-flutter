import 'package:app/core/domain/community/community_user/community_user.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/core/utils/device_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunitySpotlightItem extends StatelessWidget {
  const CommunitySpotlightItem({
    super.key,
    required this.user,
  });
  final CommunityUser user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isIpad = DeviceUtils.isIpad();
    return SizedBox(
      width: isIpad ? 144.w : 96.w,
      child: Column(
        children: [
          LemonCircleAvatar(
            size: 90.w,
            url: AvatarUtils.getProfileAvatar(
              userAvatar: user.imageAvatar,
              userId: user.id,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Spacing.xSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  user.displayName ?? user.userName ?? '',
                  style: Typo.medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  user.userName ?? '',
                  style: Typo.small.copyWith(
                    fontWeight: FontWeight.w400,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
