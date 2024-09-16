import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEventRegistrationSection extends StatelessWidget {
  const CreateEventRegistrationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Registration',
            style: Typo.medium.copyWith(
              color: colorScheme.onSurface.withOpacity(0.54),
            ),
          ),
          SizedBox(height: Spacing.xSmall),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
            child: Column(
              children: [
                _buildSettingRow(
                  context,
                  icon: Assets.icons.icPublic,
                  title: 'Visibility',
                  value: 'Public',
                  trailingIcon: Assets.icons.icArrowUpDown,
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: LemonColor.white06,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  margin: EdgeInsets.only(
                    left: Spacing.xLarge + Spacing.superExtraSmall,
                  ),
                ),
                _buildSettingRow(
                  context,
                  icon: Assets.icons.icOutlineVerified,
                  title: 'Require approval',
                  isSwitch: true,
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: LemonColor.white06,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  margin: EdgeInsets.only(
                    left: Spacing.xLarge + Spacing.superExtraSmall,
                  ),
                ),
                _buildSettingRow(
                  context,
                  icon: Assets.icons.icArrowUpToLine,
                  title: 'Guest limit',
                  value: 'Unlimited',
                  trailingIcon: Assets.icons.icEdit,
                ),
                Container(
                  height: 1.h,
                  decoration: BoxDecoration(
                    color: LemonColor.white06,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  margin: EdgeInsets.only(
                    left: Spacing.xLarge + Spacing.superExtraSmall,
                  ),
                ),
                _buildSettingRow(
                  context,
                  icon: Assets.icons.icPersonAddOutline,
                  title: 'Invite limit per guest',
                  value: 'Unlimited',
                  trailingIcon: Assets.icons.icEdit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(BuildContext context,
      {required SvgGenImage icon,
      required String title,
      String? value,
      bool isSwitch = false,
      SvgGenImage? trailingIcon,
      prop}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      child: Row(
        children: [
          Center(
            child: SizedBox(
              width: Sizing.mSmall,
              height: Sizing.mSmall,
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => icon.svg(
                  width: Sizing.mSmall,
                  height: Sizing.mSmall,
                  colorFilter: filter,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              title,
              style: Typo.medium.copyWith(color: colorScheme.onPrimary),
            ),
          ),
          if (isSwitch)
            SizedBox(
              height: Sizing.small,
              child: Switch(
                value: false,
                onChanged: (_) {},
                activeColor: colorScheme.primary,
              ),
            )
          else if (value != null) ...[
            Text(
              value,
              style: Typo.medium.copyWith(color: colorScheme.onPrimary),
            ),
            SizedBox(width: Spacing.xSmall),
            if (trailingIcon != null) // Check if trailingIcon is provided
              ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => trailingIcon.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  colorFilter: filter,
                ),
              ),
          ],
        ],
      ),
    );
  }
}
