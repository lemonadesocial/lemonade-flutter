import 'package:app/core/presentation/pages/event/sub_events_listing_page/mock_events.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_hourly_view.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_regular_view.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/widgets/sub_events_date_filter_bar.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SubEventViewMode {
  listing,
  calendar,
}

@RoutePage()
class SubEventsListingV2Page extends StatefulWidget {
  final String parentEventId;
  const SubEventsListingV2Page({
    super.key,
    required this.parentEventId,
  });

  @override
  State<SubEventsListingV2Page> createState() => _SubEventsListingV2PageState();
}

class _SubEventsListingV2PageState extends State<SubEventsListingV2Page> {
  final eventCtrl = EventController();
  DateTime _selectedDate = DateTime.now();
  GlobalKey<DayViewState> hourlyViewState = GlobalKey();
  bool _calendarVisible = false;
  double _lastOffset = 0; // initialize lastOffset with a default value
  bool _isMonthChanging = false;
  final Debouncer _debouncer = Debouncer(milliseconds: 200);
  SubEventViewMode _viewMode = SubEventViewMode.calendar;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _calendarVisible = !_calendarVisible;
    });
  }

  void _onScroll(ScrollMetrics metrics) {
    final offset = metrics.pixels;
    if (offset > _lastOffset &&
        offset > 0 &&
        offset - _lastOffset > 5 /*&& offset < metrics.maxScrollExtent*/) {
      if (!_isMonthChanging) {
        setState(() {
          _calendarVisible = false;
        });
      }
    }
    _lastOffset = offset;
  }

  void _onDateChanged(DateTime date) {
    _isMonthChanging = true;
    setState(() {
      _selectedDate = date;
    });
    hourlyViewState.currentState?.jumpToDate(date);
    _debouncer.run(() {
      _isMonthChanging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.subEvent.sessions,
        actions: [
          InkWell(
            onTap: () {
              AutoRouter.of(context).push(
                CreateEventRoute(
                  parentEventId: widget.parentEventId,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.xSmall,
              ),
              child: Icon(
                Icons.add,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
              vertical: Spacing.small,
            ),
            child: SubEventsDateFilterBar(
              selectedDate: _selectedDate,
              viewMode: _viewMode,
              onToggle: _toggle,
              onViewModeChange: (mode) {
                setState(() {
                  _viewMode = mode;
                });
              },
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _calendarVisible ? 1 : 0,
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(
                horizontal: Spacing.xSmall,
              ),
              padding: EdgeInsets.only(
                top: Spacing.xSmall,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(LemonRadius.medium),
                border: Border.all(
                  color: colorScheme.outline,
                  width: 1.w,
                ),
              ),
              duration: const Duration(milliseconds: 300),
              height: _calendarVisible ? 250 : 0,
              child: CalendarDatePicker2(
                config: CalendarDatePicker2WithActionButtonsConfig(
                  controlsHeight: 0,
                  nextMonthIcon: const SizedBox.shrink(),
                  lastMonthIcon: const SizedBox.shrink(),
                  calendarType: CalendarDatePicker2Type.single,
                  selectedDayTextStyle: TextStyle(
                    color: LemonColor.paleViolet,
                    fontWeight: FontWeight.w700,
                  ),
                  selectedDayHighlightColor: LemonColor.paleViolet18,
                  customModePickerIcon: const SizedBox(),
                  todayTextStyle:
                      Typo.small.copyWith(color: colorScheme.onPrimary),
                  dayTextStyle:
                      Typo.small.copyWith(color: colorScheme.onPrimary),
                ),
                value: [_selectedDate],
                onDisplayedMonthChanged: (date) {
                  _onDateChanged(date);
                },
                onValueChanged: (dates) {
                  if (dates.isNotEmpty) {
                    _onDateChanged(dates[0]!);
                  }
                },
              ),
            ),
          ),
          if (_viewMode == SubEventViewMode.listing)
            SubEventsListingRegularView(
              isCalendarShowing: _calendarVisible,
              onScroll: _onScroll,
            ),
          if (_viewMode == SubEventViewMode.calendar)
            CalendarControllerProvider(
              controller: eventCtrl..addAll(mock_events),
              child: SubEventsListingHourlyView(
                state: hourlyViewState,
                selectedDate: _selectedDate,
                isCalendarShowing: _calendarVisible,
                onDateChanged: (date) => setState(() {
                  _selectedDate = date;
                }),
                onScroll: _onScroll,
              ),
            ),
        ],
      ),
    );
  }
}
