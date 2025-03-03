import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/wheel_time_picker/wheel_time_picker.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class StakeVaultDateTimeSelectionButtons extends StatelessWidget {
  final DateTime dateTime;
  final Function(DateTime) onDateTimeChanged;

  const StakeVaultDateTimeSelectionButtons({
    super.key,
    required this.dateTime,
    required this.onDateTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _showDatePicker(context),
            child: Container(
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(LemonRadius.medium),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateFormat.format(dateTime),
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icDoubleArrowUpDown.svg(
                      colorFilter: filter,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Expanded(
          child: InkWell(
            onTap: () => _showTimePicker(context),
            child: Container(
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(LemonRadius.medium),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeFormat.format(dateTime),
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icDoubleArrowUpDown.svg(
                      colorFilter: filter,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => SizedBox(
        height: 400.w,
        child: Column(
          children: [
            const BottomSheetGrabber(),
            SizedBox(height: Spacing.small),
            Expanded(
              child: CalendarDatePicker2(
                config: CalendarDatePicker2WithActionButtonsConfig(
                  firstDayOfWeek: 1,
                  calendarType: CalendarDatePicker2Type.single,
                  selectedDayTextStyle: Typo.medium.copyWith(
                    color: LemonColor.paleViolet,
                    fontWeight: FontWeight.w700,
                  ),
                  selectedDayHighlightColor: LemonColor.paleViolet18,
                  customModePickerIcon: const SizedBox(),
                  todayTextStyle: Typo.small.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  dayTextStyle: Typo.small.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                value: [dateTime],
                onValueChanged: (dates) {
                  if (dates.isNotEmpty && dates[0] != null) {
                    final newDate = dates[0]!;
                    final updatedDateTime = DateTime(
                      newDate.year,
                      newDate.month,
                      newDate.day,
                      dateTime.hour,
                      dateTime.minute,
                    );
                    onDateTimeChanged(updatedDateTime);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      builder: (context) => SizedBox(
        height: 300.w,
        child: Column(
          children: [
            const BottomSheetGrabber(),
            SizedBox(height: Spacing.small),
            Expanded(
              child: WheelTimePicker(
                timeOfDay: TimeOfDay.fromDateTime(dateTime),
                onTimeChanged: (timeOfDay) {
                  final updatedDateTime = DateTime(
                    dateTime.year,
                    dateTime.month,
                    dateTime.day,
                    timeOfDay.hour,
                    timeOfDay.minute,
                  );
                  onDateTimeChanged(updatedDateTime);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
