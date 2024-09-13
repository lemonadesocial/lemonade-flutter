import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/helpers/sub_events_helper.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/widgets/sub_events_empty_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SubEventsListingListView extends StatelessWidget {
  final bool isCalendarShowing;
  final void Function(ScrollMetrics metrics)? onScroll;
  final AutoScrollController _scrollController = AutoScrollController();
  final String parentEventId;

  SubEventsListingListView({
    super.key,
    required this.parentEventId,
    this.isCalendarShowing = false,
    this.onScroll,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSubEventsByCalendarBloc, GetSubEventsByCalendarState>(
      builder: (context, state) {
        final selectedDate = state.selectedDate;
        final eventsGroupByDate = state.eventsGroupByDate.map(
          (date, events) => MapEntry(
            date,
            events
                .where(
                  (event) => getSubEventByFilter(
                    event,
                    selectedHosts: state.selectedHosts,
                    selectedTags: state.selectedTags,
                  ),
                )
                .toList(),
          ),
        );
        final datesInMonth = selectedDate.datesOfMonths();
        if (eventsGroupByDate.isEmpty) {
          return Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(top: Spacing.small),
                  sliver: const SliverToBoxAdapter(
                    child: SubEventsEmptyWidget(),
                  ),
                ),
              ],
            ),
          );
        }
        return Expanded(
          child: Column(
            children: [
              if (isCalendarShowing) SizedBox(height: Spacing.xSmall),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.xSmall,
                  ),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification) {
                        onScroll?.call(notification.metrics);
                      }
                      return true;
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        ...datesInMonth.asMap().entries.map((entry) {
                          final dateInMonth = entry.value.withoutTime;
                          final events = eventsGroupByDate[dateInMonth] ?? [];
                          if (DateUtils.isSameDay(selectedDate, dateInMonth)) {
                            return _EventsByDateSection(
                              selectedDate: selectedDate,
                              date: dateInMonth,
                              events: events,
                              onEmptyTap: () {
                                AutoRouter.of(context).push(
                                  CreateEventRoute(
                                    parentEventId: parentEventId,
                                  ),
                                );
                              },
                            );
                          }
                          if (events.isEmpty ||
                              (dateInMonth.month != selectedDate.month &&
                                  dateInMonth.year != selectedDate.year)) {
                            return const SliverToBoxAdapter(
                              child: SizedBox.shrink(),
                            );
                          }
                          return _EventsByDateSection(
                            selectedDate: selectedDate,
                            date: dateInMonth,
                            events: events,
                            onEmptyTap: () {
                              AutoRouter.of(context).push(
                                CreateEventRoute(
                                  parentEventId: parentEventId,
                                ),
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EventsByDateSection extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime date;
  final List<Event> events;
  final VoidCallback? onEmptyTap;

  const _EventsByDateSection({
    required this.date,
    required this.events,
    required this.selectedDate,
    this.onEmptyTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (events.isEmpty && !DateUtils.isSameDay(selectedDate, date)) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            DateFormatUtils.custom(date, pattern: 'MMM d, EEEE'),
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.xSmall),
        ),
        if (events.isEmpty)
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                onEmptyTap?.call();
              },
              child: Text(
                t.event.subEvent.emptySessions,
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        if (events.isNotEmpty)
          SliverList.separated(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return _EventItem(event: events[index]);
            },
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.xSmall),
          ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.medium),
        ),
      ],
    );
  }
}

class _EventItem extends StatelessWidget {
  final Event event;
  const _EventItem({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(EventDetailRoute(eventId: event.id ?? ''));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          color: LemonColor.atomicBlack,
        ),
        padding: EdgeInsets.all(Spacing.medium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  _Tile(
                    icon: LemonNetworkImage(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      imageUrl: event.hostExpanded?.imageAvatar ?? "",
                      borderRadius: BorderRadius.circular(Sizing.xSmall),
                      placeholder: ImagePlaceholder.avatarPlaceholder(),
                    ),
                    title:
                        '${t.event.hostedBy} ${event.hostExpanded?.name ?? ""}',
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  _Tile(
                    icon: Icon(
                      Icons.today_outlined,
                      size: 15.w,
                      color: colorScheme.onSecondary,
                    ),
                    title: DateFormatUtils.fullDateWithTime(
                      event.start ?? DateTime.now(),
                    ),
                  ),
                  if (event.address != null) ...[
                    SizedBox(height: Spacing.superExtraSmall),
                    _Tile(
                      icon: Assets.icons.icLocationPin.svg(
                        color: colorScheme.onSecondary,
                      ),
                      title: event.address?.city ?? '',
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: Spacing.medium),
            LemonNetworkImage(
              imageUrl: EventUtils.getEventThumbnailUrl(event: event),
              width: 90.w,
              height: 90.w,
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              placeholder: ImagePlaceholder.eventCard(),
              border: Border.all(
                color: colorScheme.outline,
                width: 1.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final Widget icon;
  final String title;
  const _Tile({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        icon,
        SizedBox(width: Spacing.superExtraSmall),
        Flexible(
          child: Text(
            title,
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
