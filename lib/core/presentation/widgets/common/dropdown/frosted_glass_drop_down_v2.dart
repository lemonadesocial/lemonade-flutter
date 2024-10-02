import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FrostedGlassDropDownV2 extends StatelessWidget {
  const FrostedGlassDropDownV2({
    super.key,
    required this.listItem,
    required this.onValueChange,
    this.selectedValue,
    this.label,
    this.hintText,
    this.showRequired,
    this.backgroundColor,
    this.labelStyle,
    this.border,
  });

  final String? label;
  final TextStyle? labelStyle;
  final String? hintText;
  final List<String> listItem;
  final String? selectedValue;
  final ValueChanged<String?> onValueChange;
  final bool? showRequired;
  final Color? backgroundColor;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: label ?? '',
                    style: labelStyle ??
                        Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                    children: [
                      if (showRequired == true)
                        TextSpan(
                          text: " *",
                          style: Typo.mediumPlus.copyWith(
                            color: LemonColor.coralReef,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.superExtraSmall),
        ],
        Container(
          width: 1.sw,
          height: 54.w,
          decoration: BoxDecoration(
            border: border,
            borderRadius: BorderRadius.circular(12.r),
            color: backgroundColor ?? colorScheme.onPrimary.withOpacity(0.06),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              items: listItem
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              hint: Text(
                hintText ?? Translations.of(context).common.selectItem,
                style: Typo.medium.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(right: Spacing.xSmall),
              ),
              value: selectedValue,
              onChanged: onValueChange,
              dropdownStyleData: DropdownStyleData(
                offset: Offset(-18.w, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: LemonColor.dropdownBackground,
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                overlayColor:
                    MaterialStatePropertyAll(LemonColor.dropdownBackground),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
