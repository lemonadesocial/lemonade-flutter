import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../gen/assets.gen.dart';

class GenderChipWidget extends StatelessWidget {
  const GenderChipWidget({
    Key? key,
    required this.label,
    required this.leading,
    required this.onSelect,
    required this.activeColor,
    required this.inActiveColor,
    required this.defaultColor,
    this.isSelected,
  }) : super(key: key);

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
    return InkWell(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21.r),
          color: isSelected == null
              ? defaultColor
              : isSelected!
                  ? activeColor
                  : LemonColor.white.withOpacity(0.06),
        ),
        padding: EdgeInsets.all(Spacing.xSmall),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: isSelected == null
                  ? activeColor
                  : isSelected!
                      ? LemonColor.black
                      : LemonColor.white36,
              builder: (filter) => leading.svg(colorFilter: filter),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            Text(
              label,
              style: Typo.medium.copyWith(
                color: isSelected == null
                    ? activeColor
                    : isSelected!
                        ? LemonColor.black
                        : LemonColor.white36,
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
