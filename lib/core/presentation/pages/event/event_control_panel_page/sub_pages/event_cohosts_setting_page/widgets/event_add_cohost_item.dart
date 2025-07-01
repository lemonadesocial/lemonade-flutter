import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventAddCohostItem extends StatelessWidget {
  final User? user;
  final Function onPressItem;
  final bool? selected;

  const EventAddCohostItem({
    super.key,
    this.user,
    required this.onPressItem,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: () async {
        onPressItem();
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    LemonCircleAvatar(
                      size: Sizing.medium,
                      url: AvatarUtils.getAvatarUrl(user: user),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.extraSmall,
                        ),
                        child: Column(
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
                  ],
                ),
              ),
              Row(
                children: [
                  selected == true
                      ? ThemeSvgIcon(
                          color: appColors.textPrimary,
                          builder: (colorFilter) => Assets.icons.icChecked.svg(
                            colorFilter: colorFilter,
                          ),
                        )
                      : ThemeSvgIcon(
                          color: appColors.textTertiary,
                          builder: (colorFilter) => Assets.icons.icUncheck.svg(
                            colorFilter: colorFilter,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
