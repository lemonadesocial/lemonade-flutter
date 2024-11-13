import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SelectRepeatModeDropdown extends StatefulWidget {
  final Enum$RecurringRepeat repeatMode;
  final Function(Enum$RecurringRepeat mode) onChange;
  const SelectRepeatModeDropdown({
    super.key,
    required this.repeatMode,
    required this.onChange,
  });

  @override
  State<SelectRepeatModeDropdown> createState() =>
      _SelectRepeatModeDropdownState();
}

class _SelectRepeatModeDropdownState extends State<SelectRepeatModeDropdown> {
  String get repeatText {
    final t = Translations.of(context);
    final text = t.event.sessionDuplication.repeat;
    if (widget.repeatMode == Enum$RecurringRepeat.daily) {
      return '$text ${t.event.sessionDuplication.daily}';
    } else if (widget.repeatMode == Enum$RecurringRepeat.weekly) {
      return '$text ${t.event.sessionDuplication.weekly}';
    } else {
      return '$text ${t.event.sessionDuplication.monthly}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<Enum$RecurringRepeat>(
          value: widget.repeatMode,
          onChanged: (value) {
            widget.onChange(value ?? Enum$RecurringRepeat.daily);
          },
          customButton: Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline),
              borderRadius: BorderRadius.circular(LemonRadius.medium),
              color: LemonColor.chineseBlack,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  repeatText,
                  style: Typo.medium.copyWith(color: colorScheme.onPrimary),
                ),
                Assets.icons.icDoubleArrowUpDown.svg(
                  color: colorScheme.onSecondary,
                ),
              ],
            ),
          ),
          items: [
            DropdownMenuItem<Enum$RecurringRepeat>(
              value: Enum$RecurringRepeat.daily,
              child: Text(
                '${t.event.sessionDuplication.repeat} ${t.event.sessionDuplication.daily}',
              ),
            ),
            DropdownMenuItem<Enum$RecurringRepeat>(
              value: Enum$RecurringRepeat.weekly,
              child: Text(
                '${t.event.sessionDuplication.repeat} ${t.event.sessionDuplication.weekly}',
              ),
            ),
            DropdownMenuItem<Enum$RecurringRepeat>(
              value: Enum$RecurringRepeat.monthly,
              child: Text(
                '${t.event.sessionDuplication.repeat} ${t.event.sessionDuplication.monthly}',
              ),
            ),
          ],
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.small),
              color: colorScheme.secondaryContainer,
            ),
            offset: Offset(0, -Spacing.superExtraSmall),
          ),
          menuItemStyleData: const MenuItemStyleData(
            overlayColor: MaterialStatePropertyAll(
              LemonColor.darkBackground,
            ),
          ),
        ),
      ),
    );
  }
}
