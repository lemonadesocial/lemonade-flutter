import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/widgets/sub_events_day_view.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/widgets/sub_events_grid_view_mode_switcher.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/widgets/sub_events_week_view.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/widgets/sub_events_month_view.dart';

enum SubEventsGridViewMode {
  day,
  week,
  month,
}

class SubEventsListingGridView extends StatefulWidget {
  final DateTime? selectedDate;
  final GlobalKey<DayViewState>? dayViewState;
  final GlobalKey<WeekViewState>? weekViewState;
  final GlobalKey<MonthViewState>? monthViewState;
  final void Function(ScrollMetrics metrics)? onScroll;
  final void Function(DateTime date)? onDateChanged;
  final bool isCalendarShowing;

  const SubEventsListingGridView({
    super.key,
    this.selectedDate,
    this.dayViewState,
    this.weekViewState,
    this.monthViewState,
    this.onScroll,
    this.onDateChanged,
    this.isCalendarShowing = false,
  });

  @override
  State<SubEventsListingGridView> createState() =>
      _SubEventsListingGridViewState();
}

class _SubEventsListingGridViewState extends State<SubEventsListingGridView> {
  SubEventsGridViewMode gridViewMode = SubEventsGridViewMode.day;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SubEventsGridViewModeSwitcher(
            gridViewMode: gridViewMode,
            onGridViewModeChanged: (mode) {
              setState(() {
                gridViewMode = mode;
              });
            },
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
              child: gridViewMode == SubEventsGridViewMode.month
                  ? SubEventsMonthView(
                      selectedDate: widget.selectedDate,
                      monthViewState: widget.monthViewState,
                      onDateChanged: widget.onDateChanged,
                      isCalendarShowing: widget.isCalendarShowing,
                    )
                  : gridViewMode == SubEventsGridViewMode.week
                      ? SubEventsWeekView(
                          selectedDate: widget.selectedDate,
                          weekViewState: widget.weekViewState,
                          onDateChanged: widget.onDateChanged,
                          isCalendarShowing: widget.isCalendarShowing,
                        )
                      : SubEventsDayView(
                          selectedDate: widget.selectedDate,
                          dayViewState: widget.dayViewState,
                          onDateChanged: widget.onDateChanged,
                          isCalendarShowing: widget.isCalendarShowing,
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
