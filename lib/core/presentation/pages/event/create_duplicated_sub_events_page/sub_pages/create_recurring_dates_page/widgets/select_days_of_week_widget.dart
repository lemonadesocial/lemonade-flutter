import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/i18n/i18n.g.dart';

class SelectDaysOfWeekWidget extends StatelessWidget {
  final List<int> selectedDays;
  final void Function(List<int>) onChangeSelectedDays;

  const SelectDaysOfWeekWidget({
    super.key,
    required this.selectedDays,
    required this.onChangeSelectedDays,
  });

  List<String> get dayTitles => [
        'M',
        'T',
        'W',
        'T',
        'F',
        'S',
        'S',
      ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.sessionDuplication.daysOfWeek,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Wrap(
          spacing: Spacing.extraSmall,
          children: dayTitles.asMap().entries.map((entry) {
            final dayValue = entry.key + 1;
            final dayTitle = entry.value;
            final selected = selectedDays.contains(dayValue);
            return InkWell(
              onTap: () {
                final newDays = [...selectedDays];
                if (selected) {
                  newDays.remove(dayValue);
                } else {
                  newDays.add(dayValue);
                }
                onChangeSelectedDays(newDays);
              },
              child: Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color:
                      selected ? LemonColor.lavender : LemonColor.chineseBlack,
                  borderRadius: BorderRadius.circular(42.r),
                  border: Border.all(
                    color: selected ? LemonColor.lavender : colorScheme.outline,
                  ),
                ),
                child: Center(
                  child: Text(
                    dayTitle,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
