import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/helpers/sub_events_helper.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_hourly_view.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_regular_view.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/widgets/sub_event_calendar_day_cell_widget.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/widgets/sub_events_date_filter_bar.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart' as calendar_view;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SubEventViewMode {
  listing,
  calendar,
}

@RoutePage()
class SubEventsListingV2Page extends StatelessWidget {
  final String parentEventId;
  const SubEventsListingV2Page({
    super.key,
    required this.parentEventId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetSubEventsByCalendarBloc(parentEventId: parentEventId)
            ..add(
              GetSubEventsByCalendarEvent.fetch(),
            ),
      child: SubEventsListingV2PageView(
        parentEventId: parentEventId,
      ),
    );
  }
}

class SubEventsListingV2PageView extends StatefulWidget {
  final String parentEventId;
  const SubEventsListingV2PageView({
    super.key,
    required this.parentEventId,
  });

  @override
  State<SubEventsListingV2PageView> createState() =>
      _SubEventsListingV2PageViewState();
}

class _SubEventsListingV2PageViewState
    extends State<SubEventsListingV2PageView> {
  final calendarViewEventCtrl = calendar_view.EventController();
  GlobalKey<calendar_view.DayViewState> hourlyViewState = GlobalKey();
  bool _calendarVisible = false;
  double _lastOffset = 0; // initialize lastOffset with a default value
  bool _isMonthChanging = false;
  final Debouncer _debouncer = Debouncer(milliseconds: 200);
  SubEventViewMode _viewMode = SubEventViewMode.calendar;
  Map<String, bool> addedCalendarEventsMap = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Event> _getEventsByDate(
    Map<DateTime, List<Event>> eventsGroupByDate,
    DateTime selectedDate,
  ) {
    return eventsGroupByDate[selectedDate.withoutTime] ?? [];
  }

  void _toggle() {
    setState(() {
      _calendarVisible = !_calendarVisible;
    });
  }

  void _onScroll(ScrollMetrics metrics) {
    final offset = metrics.pixels;
    if (offset > _lastOffset && offset > 0 && offset - _lastOffset > 5) {
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
    context.read<GetSubEventsByCalendarBloc>().add(
          GetSubEventsByCalendarEvent.dateChanged(
            selectedDate: date,
          ),
        );
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
      body:
          BlocConsumer<GetSubEventsByCalendarBloc, GetSubEventsByCalendarState>(
        listenWhen: (previous, current) =>
            previous.events.length != current.events.length,
        listener: (context, state) {
          var newCalendarEvents = getCalendarEvents(
            state.events,
          );
          var filteredCalendarEvents = newCalendarEvents
              .where((element) => addedCalendarEventsMap[element.title] == null)
              .toList();

          calendarViewEventCtrl.addAll(
            filteredCalendarEvents,
          );

          for (var item in newCalendarEvents) {
            if (addedCalendarEventsMap[item.title] == null) {
              addedCalendarEventsMap[item.title] = true;
            }
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.xSmall,
                  vertical: Spacing.small,
                ),
                child: SubEventsDateFilterBar(
                  selectedDate: state.selectedDate,
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
                duration: const Duration(milliseconds: 200),
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
                  duration: const Duration(milliseconds: 200),
                  height: _calendarVisible ? 300 : 0,
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                      controlsHeight: 0,
                      nextMonthIcon: const SizedBox.shrink(),
                      lastMonthIcon: const SizedBox.shrink(),
                      calendarType: CalendarDatePicker2Type.single,
                      selectedDayTextStyle: Typo.small.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                      selectedDayHighlightColor: LemonColor.chineseBlack,
                      customModePickerIcon: const SizedBox(),
                      todayTextStyle: Typo.small.copyWith(
                        color: LemonColor.paleViolet,
                        fontWeight: FontWeight.bold,
                      ),
                      dayTextStyle:
                          Typo.small.copyWith(color: colorScheme.onPrimary),
                      dayBorderRadius:
                          BorderRadius.circular(LemonRadius.extraSmall),
                      dayBuilder: ({
                        required date,
                        decoration,
                        isDisabled,
                        isSelected,
                        isToday,
                        textStyle,
                      }) {
                        final selected = isSelected ?? false;
                        final hasEvent = state
                                .eventsGroupByDate[date.withoutTime]
                                ?.isNotEmpty ??
                            false;
                        return SubEventCalendarDayCellWidget(
                          date: date,
                          selected: selected,
                          hasEvent: hasEvent,
                          textStyle: textStyle,
                          decoration: decoration,
                        );
                      },
                    ),
                    value: [state.selectedDate],
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
              if (_calendarVisible) SizedBox(height: Spacing.xSmall),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.xSmall,
                ),
                child: Row(
                  children: [
                    Text(
                      '${StringUtils.ordinal(state.selectedDate.day)}, ${DateFormatUtils.custom(
                        state.selectedDate,
                        pattern: "EEEE",
                      )}',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    if (DateUtils.isSameDay(state.selectedDate, DateTime.now()))
                      Text(
                        StringUtils.capitalize(t.common.today),
                      ),
                  ],
                ),
              ),
              SizedBox(height: Spacing.xSmall),
              if (_viewMode == SubEventViewMode.listing)
                SubEventsListingRegularView(
                  isCalendarShowing: _calendarVisible,
                  onScroll: _onScroll,
                  events: _getEventsByDate(
                    state.eventsGroupByDate,
                    state.selectedDate,
                  ),
                ),
              if (_viewMode == SubEventViewMode.calendar)
                calendar_view.CalendarControllerProvider(
                  controller: calendarViewEventCtrl,
                  child: SubEventsListingHourlyView(
                    state: hourlyViewState,
                    selectedDate: state.selectedDate,
                    isCalendarShowing: _calendarVisible,
                    onDateChanged: (date) {
                      context.read<GetSubEventsByCalendarBloc>().add(
                            GetSubEventsByCalendarEvent.dateChanged(
                              selectedDate: date,
                            ),
                          );
                    },
                    onScroll: _onScroll,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
