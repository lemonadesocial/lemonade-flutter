import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/app_theme/app_theme.dart';

class GenderChipWidget extends StatelessWidget {
  const GenderChipWidget({
    super.key,
    required this.label,
    required this.leading,
    required this.onSelect,
    required this.activeColor,
    required this.inActiveColor,
    required this.defaultColor,
    this.isSelected,
  });

  final String label;
  final SvgGenImage leading;
  final bool? isSelected;
  final VoidCallback onSelect;
  final Color activeColor;
  final Color inActiveColor;
  final Color defaultColor;

  /// [isSelected] will have 3 state:
  /// - null mean it is default state, no gender has been selected
  /// - true/false, meaning one of gender has been selected
  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return InkWell(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.full),
          color: isSelected == null
              ? defaultColor
              : isSelected!
                  ? activeColor
                  : appColors.buttonTertiaryBg,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.s2,
          vertical: Spacing.s1,
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: isSelected == null
                  ? activeColor
                  : isSelected!
                      ? appColors.textPrimary
                      : appColors.textTertiary,
              builder: (filter) => leading.svg(colorFilter: filter),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            Text(
              label,
              style: appText.md.copyWith(
                color: isSelected == null
                    ? activeColor
                    : isSelected!
                        ? appColors.textPrimary
                        : appColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
