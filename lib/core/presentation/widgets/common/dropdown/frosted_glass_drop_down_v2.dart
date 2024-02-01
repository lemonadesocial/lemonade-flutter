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
  });

  final String? label;
  final String? hintText;
  final List<String> listItem;
  final String? selectedValue;
  final ValueChanged<String?> onValueChange;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Typo.small.copyWith(
              color: colorScheme.onPrimary.withOpacity(0.36),
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
        ],
        Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.smMedium,
            vertical: Spacing.xSmall,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: colorScheme.onPrimary.withOpacity(0.06),
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
                  color: colorScheme.onPrimary.withOpacity(0.36),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              value: selectedValue,
              onChanged: onValueChange,
              buttonStyleData: ButtonStyleData(
                height: 40.h,
                width: 1.sw,
                overlayColor: MaterialStatePropertyAll(
                  colorScheme.onPrimary.withOpacity(
                    0.06,
                  ),
                ),
              ),
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
