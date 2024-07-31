import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubEventsListingHourlyView extends StatefulWidget {
  final DateTime? selectedDate;
  final GlobalKey<DayViewState>? state;
  final void Function(ScrollMetrics metrics)? onScroll;
  final void Function(DateTime date)? onDateChanged;
  final bool isCalendarShowing;
  const SubEventsListingHourlyView({
    super.key,
    this.selectedDate,
    this.state,
    this.onScroll,
    this.onDateChanged,
    this.isCalendarShowing = false,
  });

  @override
  State<SubEventsListingHourlyView> createState() =>
      _SubEventsListingHourlyViewState();
}

class _SubEventsListingHourlyViewState
    extends State<SubEventsListingHourlyView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Expanded(
      child: Column(
        children: [
          if (widget.isCalendarShowing) SizedBox(height: Spacing.xSmall),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
            ),
            child: Row(
              children: [
                Text(
                  DateFormatUtils.custom(
                    widget.selectedDate ?? DateTime.now(),
                    pattern: "dd, EEEE",
                  ),
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (DateUtils.isSameDay(widget.selectedDate, DateTime.now()))
                  Text(
                    StringUtils.capitalize(t.common.today),
                  ),
              ],
            ),
          ),
          SizedBox(height: Spacing.xSmall),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  widget.onScroll?.call(notification.metrics);
                }
                return true;
              },
              child: DayView(
                key: widget.state,
                backgroundColor: colorScheme.background,
                showVerticalLine: true,
                showLiveTimeLineInAllDays: true,
                liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
                  color: colorScheme.onPrimary,
                  showBullet: true,
                  height: 1.w,
                ),
                minDay: DateTime(2000),
                maxDay: DateTime(2050),
                initialDay: widget.selectedDate,
                heightPerMinute: 1, // height occupied by 1 minute time span.
                eventArranger: const SideEventArranger(
                  includeEdges: true,
                ), // To define how simultaneous events will be arranged.
                // onEventTap: (events, date) => print(events),
                // onEventDoubleTap: (events, date) => print(events),
                // onEventLongTap: (events, date) => print(events),
                // onDateLongPress: (date) => print(date),
                startHour: 5, // To set the first hour displayed (ex: 05:00)
                endHour: 24, // To set the end hour displayed
                hourIndicatorSettings: HourIndicatorSettings(
                  height: 1.w,
                  color: colorScheme.outline,
                ),
                dayTitleBuilder: (_) => const SizedBox.shrink(),
                keepScrollOffset: true,
                onPageChange: (date, page) {
                  widget.onDateChanged?.call(date);
                },
                fullDayEventBuilder: (events, date) {
                  return SizedBox(
                    child: Column(
                      children: events.map((e) => Text(e.title)).toList(),
                    ),
                  );
                },
                pageViewPhysics: widget.isCalendarShowing
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                eventTileBuilder:
                    (date, events, boundary, startDuration, endDuration) {
                  if (events.isNotEmpty) {
                    return _EventItem(eventJson: events.first.event!);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final Object eventJson;
  const _EventItem({
    required this.eventJson,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final event = Event.fromJson(eventJson as Map<String, dynamic>);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      padding: EdgeInsets.all(Spacing.xSmall),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        border: Border.all(
          color: LemonColor.paleViolet,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: Spacing.superExtraSmall,
          ),
          Text(
            '${DateFormatUtils.custom(event.start ?? DateTime.now(), pattern: 'MMM d • hh:mm a')} ${DateFormatUtils.timeOnly(event.end ?? DateTime.now())}',
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
