import 'package:app/core/presentation/pages/event/create_duplicated_sub_events_page/sub_pages/create_recurring_dates_page/create_recurring_dates_page.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class SelectRecurringEndMode extends StatelessWidget {
  final RecurringEndMode endMode;
  final void Function(RecurringEndMode) onChangeEndMode;
  final void Function(String) onChangeCount;
  final String count;
  final Enum$RecurringRepeat repeatMode;
  final DateTime endDate;
  final void Function(DateTime) onChangeEndDate;
  final String timezone;
  final List<int> selectedDays;
  final void Function(List<int>) onChangeSelectedDays;

  const SelectRecurringEndMode({
    super.key,
    required this.repeatMode,
    required this.endMode,
    required this.onChangeEndMode,
    required this.onChangeCount,
    required this.count,
    required this.endDate,
    required this.onChangeEndDate,
    required this.timezone,
    required this.selectedDays,
    required this.onChangeSelectedDays,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: _ToggleSwitch(
            endMode: endMode,
            onChangeEndMode: onChangeEndMode,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          child: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icArrowRight.svg(
              colorFilter: filter,
            ),
          ),
        ),
        if (endMode == RecurringEndMode.until)
          Expanded(
            flex: 1,
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
                    endDate,
                  ],
                );
                if (results?.isNotEmpty == true) {
                  if (results?.firstOrNull != null) {
                    final selectedDate = results!.firstOrNull!;
                    final newEndDate = tz.TZDateTime(
                      tz.getLocation(timezone),
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      endDate.hour,
                      endDate.minute,
                    );
                    onChangeEndDate(newEndDate);
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.all(Spacing.small),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  border: Border.all(color: colorScheme.outline),
                ),
                child: Center(
                  child: Text(
                    DateFormat(DateFormatUtils.dateOnlyFormat).format(endDate),
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          )
        else if (endMode == RecurringEndMode.count)
          Expanded(
            flex: 1,
            child: _DurationInput(
              repeatMode: repeatMode,
              onChangeCount: onChangeCount,
              count: count,
            ),
          ),
      ],
    );
  }
}

class _ToggleSwitch extends StatelessWidget {
  final RecurringEndMode endMode;
  final void Function(RecurringEndMode) onChangeEndMode;
  const _ToggleSwitch({
    required this.endMode,
    required this.onChangeEndMode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final decoration = BoxDecoration(
      border: Border.all(color: Colors.transparent),
      borderRadius: BorderRadius.circular(LemonRadius.small),
      color: LemonColor.chineseBlack,
    );
    final selectedDecoration = decoration.copyWith(
      border: Border.all(color: colorScheme.outlineVariant),
      color: colorScheme.outline,
    );

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                onChangeEndMode(RecurringEndMode.until);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
                decoration: endMode == RecurringEndMode.until
                    ? selectedDecoration
                    : decoration,
                child: Center(
                  child: Text(
                    t.event.sessionDuplication.untilMode,
                    style: Typo.medium.copyWith(
                      color: endMode == RecurringEndMode.until
                          ? colorScheme.onPrimary
                          : colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                onChangeEndMode(RecurringEndMode.count);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
                decoration: endMode == RecurringEndMode.count
                    ? selectedDecoration
                    : decoration,
                child: Center(
                  child: Text(
                    t.event.sessionDuplication.countMode,
                    style: Typo.medium.copyWith(
                      color: endMode == RecurringEndMode.count
                          ? colorScheme.onPrimary
                          : colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DurationInput extends StatelessWidget {
  final Enum$RecurringRepeat repeatMode;
  final void Function(String) onChangeCount;
  final String count;
  const _DurationInput({
    required this.repeatMode,
    required this.onChangeCount,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    String durationUnit = '';
    final t = Translations.of(context);
    if (repeatMode == Enum$RecurringRepeat.daily) {
      durationUnit = t.event.sessionDuplication.days;
    } else if (repeatMode == Enum$RecurringRepeat.weekly) {
      durationUnit = t.event.sessionDuplication.weeks;
    } else {
      durationUnit = t.event.sessionDuplication.months;
    }

    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 56.w,
            child: LemonTextField(
              textInputType: TextInputType.number,
              contentPadding: EdgeInsets.symmetric(horizontal: Spacing.small),
              borderColor: Colors.transparent,
              initialText: count,
              onChange: onChangeCount,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.03),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(LemonRadius.medium),
                  bottomRight: Radius.circular(LemonRadius.medium),
                ),
                border: Border(
                  left: BorderSide(color: colorScheme.outline),
                ),
              ),
              height: 50.w,
              child: Center(
                child: Text(
                  StringUtils.capitalize(durationUnit),
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
