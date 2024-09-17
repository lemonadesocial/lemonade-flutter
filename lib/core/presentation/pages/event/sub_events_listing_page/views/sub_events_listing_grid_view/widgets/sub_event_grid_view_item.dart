import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/helpers/sub_events_helper.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_grid_view/sub_events_listing_grid_view.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubEventGridViewItem extends StatelessWidget {
  final SubEventsGridViewMode viewMode;
  final Object eventJson;
  const SubEventGridViewItem({
    super.key,
    required this.eventJson,
    required this.viewMode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final event = Event.fromJson(eventJson as Map<String, dynamic>);
    final isPast = event.end?.isBefore(DateTime.now()) ?? false;
    bool isFullDayEvent = (event.end?.year ?? 0) >= (event.start?.year ?? 0) &&
        (event.end?.month ?? 0) >= (event.start?.month ?? 0) &&
        (event.end?.day ?? 0) > (event.start?.day ?? 0);
    const fulldayEventTimeFormatPattern = "MMM d • hh:mm a";

    return BlocBuilder<GetSubEventsByCalendarBloc, GetSubEventsByCalendarState>(
      builder: (context, state) {
        final visible = getSubEventByFilter(
          event,
          selectedHosts: state.selectedHosts,
          selectedTags: state.selectedTags,
        );
        if (!visible) {
          return const SizedBox.shrink();
        }

        return InkWell(
          onTap: () {
            if (event.id != null) {
              AutoRouter.of(context).push(
                EventDetailRoute(eventId: event.id!),
              );
            }
          },
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            padding: EdgeInsets.all(Spacing.superExtraSmall),
            decoration: BoxDecoration(
              color: isPast ? LemonColor.chineseBlack : LemonColor.paleViolet12,
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              border: Border.all(
                color: LemonColor.paleViolet,
                width: 1.w,
              ),
            ),
            child: Builder(
              builder: (context) {
                if (viewMode == SubEventsGridViewMode.week) {
                  return Text(
                    event.title ?? '',
                    style: Typo.small.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }
                return _DayViewBody(
                  event: event,
                  isFullDayEvent: isFullDayEvent,
                  fulldayEventTimeFormatPattern: fulldayEventTimeFormatPattern,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _DayViewBody extends StatelessWidget {
  const _DayViewBody({
    required this.event,
    required this.isFullDayEvent,
    required this.fulldayEventTimeFormatPattern,
  });

  final Event event;
  final bool isFullDayEvent;
  final String fulldayEventTimeFormatPattern;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Wrap(
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
    );
  }
}
