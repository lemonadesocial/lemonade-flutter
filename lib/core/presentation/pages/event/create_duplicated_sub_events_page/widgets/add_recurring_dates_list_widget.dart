import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/sub_pages/create_recurring_dates_page/create_recurring_dates_page.dart';
import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/widgets/select_time_of_day_bottomsheet.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:app/app_theme/app_theme.dart';

class AddRecurringDatesListWidget extends StatelessWidget {
  final List<DateTime> dates;
  final Function(List<DateTime>)? onDatesChanged;
  final Event subEvent;
  final String timezone;

  const AddRecurringDatesListWidget({
    super.key,
    required this.dates,
    required this.subEvent,
    required this.timezone,
    this.onDatesChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final addIcon = ThemeSvgIcon(
      color: colorScheme.onSecondary,
      builder: (filter) => Assets.icons.icAdd.svg(
        colorFilter: filter,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.sessionDuplication.newTime,
          style: Typo.medium.copyWith(
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        ...dates.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final date = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: Spacing.xSmall),
              child: _RecurringDateItem(
                timezone: timezone,
                date: date,
                onUpdate: (newDate) {
                  final newDates = [...dates];
                  newDates[index] = newDate;
                  onDatesChanged?.call(newDates);
                },
                onRemove: () {
                  final newDates = [...dates];
                  newDates.removeAt(index);
                  onDatesChanged?.call(newDates);
                },
              ),
            );
          },
        ),
        if (dates.isEmpty) SizedBox(height: Spacing.xSmall),
        Row(
          children: [
            LemonOutlineButton(
              label: t.event.sessionDuplication.addTime,
              leading: addIcon,
              radius: BorderRadius.circular(LemonRadius.medium),
              onTap: () {
                DateTime? newDate = dates.lastOrNull;
                newDate ??= tz.TZDateTime.from(
                  DateTime.now().toUtc(),
                  tz.getLocation(timezone),
                );
                newDate = newDate.add(
                  const Duration(
                    days: 1,
                  ),
                );
                final sortedDates = <DateTime>{...dates, newDate}.toList();
                sortedDates.sort();
                onDatesChanged?.call(sortedDates);
              },
            ),
            SizedBox(width: Spacing.xSmall),
            LemonOutlineButton(
              label: t.event.sessionDuplication.recurrence,
              leading: addIcon,
              backgroundColor: appColors.cardBg,
              radius: BorderRadius.circular(LemonRadius.medium),
              onTap: () async {
                List<DateTime>? newDates =
                    await showCupertinoModalBottomSheet<List<DateTime>?>(
                  context: context,
                  builder: (context) => CreateRecurringDatesPage(
                    timezone: timezone,
                    subEvent: subEvent,
                    initialStartDate: dates.lastOrNull,
                  ),
                );
                if (newDates != null) {
                  final sortedDates =
                      <DateTime>{...newDates, ...dates}.toList();
                  sortedDates.sort();
                  onDatesChanged?.call(sortedDates);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _RecurringDateItem extends StatelessWidget {
  final DateTime date;
  final String timezone;
  final Function()? onRemove;
  final void Function(DateTime)? onUpdate;
  const _RecurringDateItem({
    required this.date,
    required this.timezone,
    this.onRemove,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appColors = context.theme.appColors;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: () async {
              final results = await showCalendarDatePicker2Dialog(
                dialogBackgroundColor: LemonColor.atomicBlack,
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(
                  firstDayOfWeek: 1,
                  calendarType: CalendarDatePicker2Type.single,
                  selectedDayTextStyle: Typo.medium.copyWith(
                    color: LemonColor.paleViolet,
                    fontWeight: FontWeight.w700,
                  ),
                  selectedDayHighlightColor: LemonColor.paleViolet18,
                  todayTextStyle:
                      Typo.medium.copyWith(color: colorScheme.onPrimary),
                  okButtonTextStyle: Typo.medium.copyWith(
                    color: LemonColor.paleViolet,
                    fontWeight: FontWeight.w600,
                  ),
                  cancelButtonTextStyle: Typo.medium.copyWith(
                    color: LemonColor.paleViolet,
                    fontWeight: FontWeight.w600,
                  ),
                  dayTextStyle:
                      Typo.small.copyWith(color: colorScheme.onPrimary),
                ),
                dialogSize: Size(1.sw, 0.5.sw),
                value: [
                  date,
                ],
              );
              if (results?.isNotEmpty == true) {
                if (results?.firstOrNull != null) {
                  final selectedDate = results!.firstOrNull!;
                  final newDate = tz.TZDateTime(
                    tz.getLocation(timezone),
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    date.hour,
                    date.minute,
                  );
                  onUpdate?.call(newDate);
                }
              }
            },
            child: Container(
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.medium),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Text(
                DateFormat('EE, MMMM d').format(
                  date,
                ),
                style: Typo.medium.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () async {
              final timeOfDay = await showCupertinoModalBottomSheet<TimeOfDay?>(
                context: context,
                expand: false,
                backgroundColor: appColors.pageBg,
                barrierColor: Colors.black.withOpacity(0.5),
                builder: (context) => SelectTimeOfDayBottomSheet(date: date),
              );
              if (timeOfDay != null) {
                onUpdate?.call(
                  tz.TZDateTime(
                    tz.getLocation(timezone),
                    date.year,
                    date.month,
                    date.day,
                    timeOfDay.hour,
                    timeOfDay.minute,
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.medium),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Text(
                DateFormat(DateFormatUtils.timeOnlyFormat).format(
                  date,
                ),
                style: Typo.medium.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        InkWell(
          onTap: () {
            onRemove?.call();
          },
          child: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icClose.svg(
              colorFilter: filter,
            ),
          ),
        ),
      ],
    );
  }
}
