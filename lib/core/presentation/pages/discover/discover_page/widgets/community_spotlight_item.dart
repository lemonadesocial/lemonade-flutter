import 'package:app/core/domain/community/community_user/community_user.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
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
          LemonNetworkImage(
            width: 96.w,
            height: 96.w,
            imageUrl: AvatarUtils.getProfileAvatar(
              userAvatar: user.imageAvatar,
              userId: user.id,
            ),
            borderRadius: BorderRadius.circular(LemonRadius.small),
          ),
          Padding(
            padding: EdgeInsets.only(top: Spacing.xSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  user.displayName ?? user.userName ?? '',
                  style: Typo.small.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.w),
                Text(
                  user.userName?.isNotEmpty == true ? "@${user.userName}" : '',
                  style: Typo.xSmall.copyWith(
                    fontWeight: FontWeight.w400,
                    color: colorScheme.onSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
