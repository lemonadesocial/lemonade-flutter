import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCohostSettingItem extends StatelessWidget {
  final User? user;
  final void Function()? onPressItem;
  final Widget? trailing;

  const EventCohostSettingItem({
    super.key,
    this.user,
    this.onPressItem,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: onPressItem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          LemonCircleAvatar(
            size: Sizing.medium,
            url: AvatarUtils.getAvatarUrl(user: user),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.extraSmall,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? '',
                    style: Typo.medium.copyWith(
                      color: appColors.textPrimary,
                    ),
                  ),
                  if (user?.email?.isNotEmpty == true) ...[
                    SizedBox(
                      height: 2.w,
                    ),
                    Text(
                      user?.email ?? '',
                      style: Typo.medium.copyWith(
                        color: appColors.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
