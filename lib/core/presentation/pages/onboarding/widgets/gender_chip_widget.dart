import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

import 'package:app/gen/assets.gen.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.button),
          color: isSelected == null
              ? defaultColor
              : isSelected!
                  ? activeColor
                  : colorScheme.onPrimary.withOpacity(0.06),
        ),
        padding: EdgeInsets.all(Spacing.xSmall),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: isSelected == null
                  ? activeColor
                  : isSelected!
                      ? colorScheme.primary
                      : colorScheme.onPrimary.withOpacity(0.36),
              builder: (filter) => leading.svg(colorFilter: filter),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            Text(
              label,
              style: Typo.medium.copyWith(
                color: isSelected == null
                    ? activeColor
                    : isSelected!
                        ? colorScheme.primary
                        : colorScheme.onPrimary.withOpacity(0.36),
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.nohemiVariable,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
