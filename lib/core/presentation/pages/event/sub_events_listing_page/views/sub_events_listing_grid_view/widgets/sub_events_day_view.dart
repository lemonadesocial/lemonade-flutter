import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/sub_events_listing_grid_view.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/widgets/sub_event_grid_view_item.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';

class SubEventsDayView extends StatelessWidget {
  final DateTime? selectedDate;
  final GlobalKey<DayViewState>? dayViewState;
  final void Function(DateTime date)? onDateChanged;
  final bool isCalendarShowing;

  const SubEventsDayView({
    super.key,
    this.selectedDate,
    this.dayViewState,
    this.onDateChanged,
    this.isCalendarShowing = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall,
          ),
          child: Row(
            children: [
              Text(
                '${StringUtils.ordinal(selectedDate?.day ?? 0)}, ${DateFormatUtils.custom(
                  selectedDate ?? DateTime.now(),
                  pattern: "EEEE",
                )}',
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (DateUtils.isSameDay(
                selectedDate,
                DateTime.now(),
              ))
                Text(
                  StringUtils.capitalize(t.common.today),
                ),
            ],
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        Expanded(
          child: DayView(
            key: dayViewState,
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
            initialDay: selectedDate,
            heightPerMinute: 1,
            eventArranger: const SideEventArranger(
              includeEdges: true,
            ),
            startHour: 0,
            endHour: 24,
            hourIndicatorSettings: HourIndicatorSettings(
              height: 1.w,
              color: colorScheme.outline,
            ),
            dayTitleBuilder: (_) => const SizedBox.shrink(),
            keepScrollOffset: true,
            onPageChange: (date, page) {
              onDateChanged?.call(date);
            },
            pageViewPhysics: isCalendarShowing
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            eventTileBuilder:
                (date, events, boundary, startDuration, endDuration) {
              if (events.isNotEmpty) {
                return SubEventGridViewItem(
                  eventJson: events.first.event!,
                  viewMode: SubEventsGridViewMode.day,
                );
              }
              return const SizedBox.shrink();
            },
            fullDayEventBuilder: (calendarEvents, date) {
              final filteredCalendarEvents = calendarEvents;
              if (filteredCalendarEvents.isNotEmpty) {
                return _FullDayEventsDayView(
                  events: filteredCalendarEvents,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class _FullDayEventsDayView extends StatelessWidget {
  final List<CalendarEventData> events;
  const _FullDayEventsDayView({
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.xSmall,
      ),
      decoration: const BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            events.length,
            (index) => Container(
              margin: EdgeInsets.only(
                bottom: Spacing.superExtraSmall,
              ),
              child: SubEventGridViewItem(
                eventJson: events[index].event!,
                viewMode: SubEventsGridViewMode.day,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
