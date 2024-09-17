import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/helpers/sub_events_helper.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/theme/typo.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:collection/collection.dart';

class SubEventsMonthView extends StatelessWidget {
  final DateTime? selectedDate;
  final GlobalKey<MonthViewState>? monthViewState;
  final void Function(DateTime date)? onDateChanged;
  final bool isCalendarShowing;

  const SubEventsMonthView({
    super.key,
    this.selectedDate,
    this.monthViewState,
    this.onDateChanged,
    this.isCalendarShowing = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocBuilder<GetSubEventsByCalendarBloc, GetSubEventsByCalendarState>(
      builder: (context, state) {
        return MonthView(
          borderSize: 0.5.w,
          borderColor: colorScheme.outline,
          key: monthViewState,
          minMonth: DateTime(2000),
          maxMonth: DateTime(2050),
          onPageChange: (date, page) async {
            await Future.delayed(const Duration(milliseconds: 500));
            if (selectedDate == null ||
                !date_utils.DateUtils.isInSameWeek(selectedDate!, date)) {
              final targetDate = state.eventsGroupByDate.keys.firstWhereOrNull(
                (mDate) => mDate.month == date.month && mDate.year == date.year,
              );
              onDateChanged?.call(targetDate ?? date);
            }
          },
          pageViewPhysics: isCalendarShowing
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          initialMonth: selectedDate,
          cellAspectRatio: 0.55,
          startDay: WeekDays.monday,
          headerBuilder: MonthHeader.hidden,
          showWeekTileBorder: false,
          hideDaysNotInMonth: true,
          weekDayBuilder: (dayIndex) {
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: colorScheme.background,
                border: Border(
                  left: BorderSide(
                    color: colorScheme.outline,
                    width: 0.5,
                  ),
                  right: BorderSide(
                    color: colorScheme.outline,
                    width: 0.5,
                  ),
                ),
              ),
              child: Text(
                [
                  t.common.weekDays.mon,
                  t.common.weekDays.tue,
                  t.common.weekDays.wed,
                  t.common.weekDays.thu,
                  t.common.weekDays.fri,
                  t.common.weekDays.sat,
                  t.common.weekDays.sun,
                ][dayIndex],
                style: Typo.medium.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            );
          },
          cellBuilder: (date, events, isToday, isInMonth, hideDaysNotInMonth) {
            return CustomMonthFilledCell(
              date: date,
              shouldHighlight: isToday,
              backgroundColor: colorScheme.background,
              events: events,
              isInMonth: isInMonth,
              titleColor: colorScheme.onPrimary,
              highlightColor: colorScheme.outline,
            );
          },
        );
      },
    );
  }
}

class CustomMonthFilledCell<T extends Object?> extends StatelessWidget {
  final DateTime date;
  final List<CalendarEventData<T>> events;

  final StringProvider? dateStringBuilder;

  final bool shouldHighlight;

  final Color backgroundColor;

  final Color highlightColor;

  final Color tileColor;

  final bool isInMonth;

  final double highlightRadius;

  final Color titleColor;

  final Color highlightedTitleColor;

  final bool hideDaysNotInMonth;

  const CustomMonthFilledCell({
    super.key,
    required this.date,
    required this.events,
    this.isInMonth = false,
    this.hideDaysNotInMonth = true,
    this.shouldHighlight = false,
    this.backgroundColor = Colors.blue,
    this.highlightColor = Colors.blue,
    this.tileColor = Colors.blue,
    this.highlightRadius = 11,
    this.highlightedTitleColor = Colors.white,
    this.titleColor = Colors.white,
    this.dateStringBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5.0,
          ),
          if (!(!isInMonth && hideDaysNotInMonth))
            CircleAvatar(
              radius: highlightRadius,
              backgroundColor:
                  shouldHighlight ? highlightColor : Colors.transparent,
              child: Text(
                dateStringBuilder?.call(date) ?? "${date.day}",
                style: Typo.small.copyWith(
                  color: shouldHighlight
                      ? highlightedTitleColor
                      : isInMonth
                          ? titleColor
                          : titleColor.withOpacity(0.4),
                ),
              ),
            ),
          if (events.isNotEmpty)
            Expanded(
              child: Container(
                decoration: const BoxDecoration(),
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(events.length, (index) {
                      return BlocBuilder<GetSubEventsByCalendarBloc,
                          GetSubEventsByCalendarState>(
                        builder: (context, state) {
                          final lemonadeEvent = Event.fromJson(
                            events[index].event! as Map<String, dynamic>,
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
                                EventDetailRoute(eventId: lemonadeEvent.id!),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: LemonColor.paleViolet18,
                                borderRadius: BorderRadius.circular(
                                  LemonRadius.extraSmall,
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: 2.w,
                                horizontal: 3.w,
                              ),
                              padding: EdgeInsets.all(4.w),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Builder(
                                    builder: (context) {
                                      final colorScheme =
                                          Theme.of(context).colorScheme;
                                      return Expanded(
                                        child: Text(
                                          lemonadeEvent.title ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Typo.xSmall.copyWith(
                                            color: colorScheme.onPrimary,
                                            fontWeight: FontWeight.w500,
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
                    }),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
