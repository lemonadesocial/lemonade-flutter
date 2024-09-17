import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/helpers/sub_events_helper.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/sub_events_listing_grid_view.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/widgets/sub_event_grid_view_item.dart';

class SubEventsWeekView extends StatelessWidget {
  final DateTime? selectedDate;
  final GlobalKey<WeekViewState>? weekViewState;
  final void Function(DateTime date)? onDateChanged;
  final bool isCalendarShowing;

  const SubEventsWeekView({
    super.key,
    this.selectedDate,
    this.weekViewState,
    this.onDateChanged,
    this.isCalendarShowing = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return WeekView(
      key: weekViewState,
      backgroundColor: colorScheme.background,
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
      weekDayBuilder: (date) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date.day.toString(),
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
              Text(
                [
                  t.common.weekDays.mon,
                  t.common.weekDays.tue,
                  t.common.weekDays.wed,
                  t.common.weekDays.thu,
                  t.common.weekDays.fri,
                  t.common.weekDays.sat,
                  t.common.weekDays.sun,
                ][date.weekday - 1],
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        );
      },
      weekPageHeaderBuilder: WeekHeader.hidden,
      weekNumberBuilder: (_) => const SizedBox.shrink(),
      keepScrollOffset: true,
      onPageChange: (date, page) async {
        await Future.delayed(const Duration(milliseconds: 500));
        if (selectedDate == null ||
            !date_utils.DateUtils.isInSameWeek(selectedDate!, date)) {
          onDateChanged?.call(date);
        }
      },
      pageViewPhysics: isCalendarShowing
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      eventTileBuilder: (date, events, boundary, startDuration, endDuration) {
        if (events.isNotEmpty) {
          return SubEventGridViewItem(
            eventJson: events.first.event!,
            viewMode: SubEventsGridViewMode.week,
          );
        }
        return const SizedBox.shrink();
      },
      fullDayEventBuilder: (calendarEvents, date) {
        final filteredCalendarEvents = calendarEvents;
        if (filteredCalendarEvents.isNotEmpty) {
          return _FullDayEventsWeekView(events: filteredCalendarEvents);
        }
        return const SizedBox.shrink();
      },
      fullDayHeaderTitle: t.common.allDay,
    );
  }
}

class _FullDayEventsWeekView extends StatelessWidget {
  final List<CalendarEventData> events;
  const _FullDayEventsWeekView({
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            events.length,
            (index) {
              return BlocBuilder<GetSubEventsByCalendarBloc,
                  GetSubEventsByCalendarState>(
                builder: (context, state) {
                  final lemonadeEvent = Event.fromJson(
                    events[index].event as Map<String, dynamic>,
                  );
                  final visible = getSubEventByFilter(
                    lemonadeEvent,
                    selectedHosts: state.selectedHosts,
                    selectedTags: state.selectedTags,
                  );
                  if (!visible) {
                    return const SizedBox.shrink();
                  }
                  return InkWell(
                    onTap: () {
                      AutoRouter.of(context).push(
                        EventDetailRoute(eventId: lemonadeEvent.id ?? ''),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: LemonColor.paleViolet18,
                        borderRadius:
                            BorderRadius.circular(LemonRadius.extraSmall),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 2.0,
                        horizontal: 3.0,
                      ),
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Builder(
                            builder: (context) {
                              final colorScheme = Theme.of(context).colorScheme;
                              return Expanded(
                                child: Text(
                                  lemonadeEvent.title ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Typo.xSmall.copyWith(
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
