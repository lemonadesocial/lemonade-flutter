import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    Key? key,
    required this.label,
    required this.hintText,
    required this.listItem,
    required this.onValueChange,
    this.selectedValue,
  }) : super(key: key);

  final String label;
  final String hintText;
  final List<String> listItem;
  final String? selectedValue;
  final ValueChanged<String?> onValueChange;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Spacing.medium),
        Text(
          label,
          style: Typo.small.copyWith(
            color: colorScheme.onPrimary.withOpacity(0.36),
          ),
        ),
        SizedBox(height: Spacing.superExtraSmall),
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
                          color: colorScheme.onPrimary.withOpacity(0.36),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              hint: Text(
                hintText,
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
                  color: colorScheme.onPrimary.withOpacity(0.36),
                ),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                overlayColor: MaterialStatePropertyAll(
                  colorScheme.onPrimary.withOpacity(
                    0.06,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
