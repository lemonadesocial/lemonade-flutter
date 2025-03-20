import 'package:app/core/application/space/get_my_space_event_requests_bloc/get_my_space_event_requests_bloc.dart';
import 'package:app/core/application/space/get_space_events_bloc/get_space_events_bloc.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/home_event_card.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_events_header.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_events.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SpaceEventsList extends StatefulWidget {
  final Space space;
  const SpaceEventsList({
    super.key,
    required this.space,
  });

  @override
  State<SpaceEventsList> createState() => _SpaceEventsListState();
}

class _SpaceEventsListState extends State<SpaceEventsList> {
  void _onFetchEvents(SpaceTag? tag) {
    context.read<GetSpaceEventsBloc>().add(
          GetSpaceEventsEvent.fetch(
            input: Variables$Query$GetEvents(
              space: widget.space.id,
              limit: 50,
              endFrom: DateTime.now().toUtc(),
              sort: Input$EventSortInput(
                start: Enum$SortOrder.asc,
              ),
              spaceTags: tag?.id != null ? [tag!.id] : null,
            ),
          ),
        );
  }

  void _onFetchSpaceEventRequests() {
    if (widget.space.id == null) {
      return;
    }
    context.read<GetMySpaceEventRequestsBloc>().add(
          GetMySpaceEventRequestsEvent.fetch(
            spaceId: widget.space.id!,
            limit: 100,
            skip: 0,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: SpaceEventsHeader(
            space: widget.space,
            onTagChange: (tag) {
              _onFetchEvents(tag);
            },
            onRefresh: (tag) {
              _onFetchEvents(tag);
              _onFetchSpaceEventRequests();
            },
          ),
        ),
        BlocBuilder<GetSpaceEventsBloc, GetSpaceEventsState>(
          builder: (context, state) {
            return state.maybeWhen(
              success: (events) {
                if (events.isEmpty) {
                  return SliverToBoxAdapter(
                    child: SafeArea(
                      top: false,
                      child: EmptyList(
                        emptyText: t.event.noEvents,
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.small,
                  ),
                  sliver: SliverList.separated(
                    addAutomaticKeepAlives: false,
                    itemBuilder: (context, index) {
                      return HomeEventCard(
                        event: events[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: Spacing.small);
                    },
                    itemCount: events.length,
                  ),
                );
              },
              orElse: () {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Loading.defaultLoading(context),
                  ),
                );
              },
            );
          },
        ),
        const SliverToBoxAdapter(
          child: SafeArea(
            top: false,
            child: SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
