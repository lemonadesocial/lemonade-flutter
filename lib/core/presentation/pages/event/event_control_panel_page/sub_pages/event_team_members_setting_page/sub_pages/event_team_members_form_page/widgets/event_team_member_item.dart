import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTeamMemberItem extends StatelessWidget {
  const EventTeamMemberItem({
    super.key,
    required this.userItem,
    required this.onRemove,
  });
  final dynamic userItem;
  final Function()? onRemove;

  String getLabelDisplay() {
    if (userItem is User) {
      return userItem.name;
    }
    return userItem;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: ShapeDecoration(
        color: colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.small),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userItem is User
              ? LemonCircleAvatar(
                  size: Sizing.medium / 2,
                  url: AvatarUtils.getAvatarUrl(user: userItem),
                )
              : Center(
                  child: ThemeSvgIcon(
                    color: colorScheme.onPrimary,
                    builder: (filter) => Assets.icons.icEmailAt.svg(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      colorFilter: filter,
                    ),
                  ),
                ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: SizedBox(
              child: Text(
                getLabelDisplay(),
                style: Typo.mediumPlus.copyWith(
                  color: colorScheme.onPrimary,
                  height: 0,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          InkWell(
            onTap: () {
              if (onRemove != null) onRemove?.call();
            },
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icClose.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
