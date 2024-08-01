import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
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
    return Expanded(
      child: Column(
        children: [
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
                ),
                startHour: 5,
                endHour: 24,
                hourIndicatorSettings: HourIndicatorSettings(
                  height: 1.w,
                  color: colorScheme.outline,
                ),
                dayTitleBuilder: (_) => const SizedBox.shrink(),
                keepScrollOffset: true,
                onPageChange: (date, page) {
                  widget.onDateChanged?.call(date);
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
                fullDayEventBuilder: (calendarEvents, date) {
                  final filteredCalendarEvents =
                      calendarEvents; // = calendarEvents.unique((item) => item.title);
                  if (filteredCalendarEvents.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.xSmall,
                      ),
                      child: Column(
                        children: filteredCalendarEvents.map((e) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: Spacing.superExtraSmall,
                            ),
                            child: _EventItem(eventJson: e.event!),
                          );
                        }).toList(),
                      ),
                    );
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
    final isPast = event.end?.isBefore(DateTime.now()) ?? false;
    final isFullDayEvent =
        (event.end?.difference(event.start!).inDays ?? 0) >= 1;
    const fulldayEventTimeFormatPattern = "MMM d • hh:mm a";

    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          EventDetailRoute(eventId: event.id ?? ''),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        padding: EdgeInsets.all(Spacing.xSmall),
        decoration: BoxDecoration(
          color: isPast ? LemonColor.chineseBlack : LemonColor.paleViolet12,
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
          border: Border.all(
            color: LemonColor.paleViolet,
            width: 1.w,
          ),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 3.w,
          children: [
            Text(
              event.title ?? '',
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icHostOutline.svg(
                    colorFilter: filter,
                    width: 12.w,
                    height: 12.w,
                  ),
                ),
                SizedBox(width: 3.w),
                Flexible(
                  child: Text(
                    event.hostExpanded?.name ?? '',
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (isFullDayEvent)
              Text(
                '${DateFormatUtils.custom(
                  event.start ?? DateTime.now(),
                  pattern: fulldayEventTimeFormatPattern,
                )} - ${DateFormatUtils.custom(
                  event.end ?? DateTime.now(),
                  pattern: fulldayEventTimeFormatPattern,
                )}',
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
