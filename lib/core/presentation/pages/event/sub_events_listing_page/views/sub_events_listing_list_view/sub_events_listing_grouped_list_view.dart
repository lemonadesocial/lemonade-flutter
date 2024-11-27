import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/helpers/sub_events_helper.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_list_view/widgets/sub_event_list_view_item.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/widgets/sub_events_empty_widget.dart';
import 'package:app/core/presentation/widgets/common/sticky_grouped_list/sticky_grouped_list.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubEventsListingGroupedListView extends StatefulWidget {
  final bool isCalendarShowing;
  final void Function(ScrollMetrics metrics)? onScroll;
  final String parentEventId;
  final GroupedItemScrollController scrollController;

  const SubEventsListingGroupedListView({
    super.key,
    required this.parentEventId,
    required this.scrollController,
    this.isCalendarShowing = false,
    this.onScroll,
  });

  @override
  State<SubEventsListingGroupedListView> createState() =>
      _SubEventsListingGroupedListViewState();
}

class _SubEventsListingGroupedListViewState
    extends State<SubEventsListingGroupedListView> {
  bool _initialScrolled = false;

  @override
  Widget build(BuildContext context) {
    final colorsScheme = Theme.of(context).colorScheme;
    return BlocConsumer<GetSubEventsByCalendarBloc,
        GetSubEventsByCalendarState>(
      listener: (context, state) {
        if (state.isLoading) return;
        if (state.events.isEmpty) return;
        if (_initialScrolled) return;
        if (!widget.scrollController.isAttached) {
          return;
        }
        widget.scrollController.scrollToElement(
          identifier:
              '${state.selectedDate.year}-${state.selectedDate.month}-${state.selectedDate.day}',
          duration: const Duration(
            milliseconds: 300,
          ),
        );
        _initialScrolled = true;
      },
      builder: (context, state) {
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
        final datesInMonth = List.generate(
          DateUtils.getDaysInMonth(
            state.selectedDate.year,
            state.selectedDate.month,
          ),
          (index) => DateTime(
            state.selectedDate.year,
            state.selectedDate.month,
            index + 1,
          ),
        );
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
              if (widget.isCalendarShowing) SizedBox(height: Spacing.xSmall),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.xSmall,
                  ),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification) {
                        widget.onScroll?.call(notification.metrics);
                      }
                      return true;
                    },
                    child: StickyGroupedListView<DateTime, DateTime>(
                      itemScrollController: widget.scrollController,
                      elements: datesInMonth,
                      elementIdentifier: (item) =>
                          '${item.year}-${item.month}-${item.day}',
                      groupBy: (item) => item,
                      groupSeparatorBuilder: (DateTime mDate) {
                        final date = mDate;
                        final events = eventsGroupByDate[date];
                        if ((events == null || events.isEmpty) &&
                            !DateUtils.isSameDay(
                              state.selectedDate.withoutTime,
                              date.withoutTime,
                            )) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: EdgeInsets.only(bottom: Spacing.small),
                          child: Text(
                            DateFormatUtils.custom(
                              date,
                              pattern: 'MMM d, EEEE',
                            ),
                            style: Typo.medium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      stickyHeaderBackgroundColor: colorsScheme.background,
                      itemBuilder: (context, date) => _EventsByDateSection(
                        date: date,
                        events: eventsGroupByDate[date.withoutTime] ?? [],
                        selectedDate: state.selectedDate,
                        onEmptyTap: () {
                          AutoRouter.of(context).push(
                            CreateEventRoute(
                              parentEventId: widget.parentEventId,
                            ),
                          );
                        },
                      ),
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
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (events.isEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: Spacing.small),
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
          ListView.separated(
            padding: EdgeInsets.only(bottom: Spacing.small),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return SubEventListViewItem(event: events[index]);
            },
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.xSmall),
          ),
      ],
    );
  }
}
