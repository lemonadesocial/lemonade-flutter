import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/widgets/sub_event_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:app/graphql/backend/event/query/get_events.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class SubEventsListingPage extends StatefulWidget {
  final Color? backgroundColor;
  final String parentEventId;
  const SubEventsListingPage({
    super.key,
    this.backgroundColor,
    required this.parentEventId,
  });

  @override
  State<SubEventsListingPage> createState() => _SubEventsListingPageState();
}

class _SubEventsListingPageState extends State<SubEventsListingPage> {
  final Debouncer debouncer = Debouncer(milliseconds: 300);
  bool hasNextPage = true;
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: LemonAppBar(
        backgroundColor: widget.backgroundColor,
        title: t.event.subEvent.subEvents,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Query$GetEvents$Widget(
                options: Options$Query$GetEvents(
                  variables: Variables$Query$GetEvents(
                    subevent_parent: widget.parentEventId,
                    limit: 20,
                    skip: 0,
                  ),
                ),
                builder: (
                  result, {
                  refetch,
                  fetchMore,
                }) {
                  final events = (result.parsedData?.events ?? [])
                      .map(
                        (item) => Event.fromDto(
                          EventDto.fromJson(item.toJson()),
                        ),
                      )
                      .toList();
                  return _EventList(
                    onTap: (event) {},
                    events: events,
                    loading: result.isLoading,
                    hasNextPage: hasNextPage,
                    onFetchMore: () {
                      debouncer.run(
                        () {
                          fetchMore?.call(
                            FetchMoreOptions$Query$GetEvents(
                              variables: Variables$Query$GetEvents(
                                subevent_parent: widget.parentEventId,
                                limit: 20,
                                skip: events.length,
                              ),
                              updateQuery: (prev, next) {
                                final prevEvents = prev?['events'] ?? [];
                                final nextEvents =
                                    (next?['events'] as List<dynamic>?) ?? [];
                                next?['events'] = [
                                  ...prevEvents,
                                  ...nextEvents,
                                ];
                                if (nextEvents.isEmpty && mounted) {
                                  setState(() {
                                    hasNextPage = false;
                                  });
                                }
                                return next;
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  final List<Event> events;
  final bool hasNextPage;
  final bool loading;
  final Function()? onFetchMore;
  final Function(Event event)? onTap;

  const _EventList({
    required this.events,
    this.loading = true,
    this.hasNextPage = true,
    this.onFetchMore,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            if (loading || !hasNextPage) return true;
            onFetchMore?.call();
          }
        }
        return true;
      },
      child: CustomScrollView(
        slivers: [
          if (events.isEmpty && !loading)
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
              sliver: const SliverToBoxAdapter(
                child: EmptyList(),
              ),
            ),
          if (loading)
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
              sliver: SliverToBoxAdapter(
                child: Loading.defaultLoading(context),
              ),
            ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: Spacing.smMedium,
              left: Spacing.smMedium,
              right: Spacing.smMedium,
            ),
            sliver: SliverList.separated(
              itemCount: events.length + 1,
              itemBuilder: (context, index) {
                if (index == events.length) {
                  if (!hasNextPage) {
                    return const SizedBox.shrink();
                  }
                  if (events.length < 20) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.medium,
                    ),
                    child: Loading.defaultLoading(context),
                  );
                }
                return InkWell(
                  onTap: () {
                    onTap?.call(events[index]);
                  },
                  child: SubEventItem(
                    event: events[index],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: Spacing.superExtraSmall);
              },
            ),
          ),
        ],
      ),
    );
  }
}
