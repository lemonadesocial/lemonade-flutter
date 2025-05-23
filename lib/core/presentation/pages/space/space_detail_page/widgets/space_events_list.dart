import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/space/get_my_space_event_requests_bloc/get_my_space_event_requests_bloc.dart';
import 'package:app/core/application/space/get_space_event_requests_bloc/get_space_event_requests_bloc.dart';
import 'package:app/core/application/space/get_space_events_bloc/get_space_events_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:app/core/domain/space/entities/space_tag.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_empty_events_widget.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_event_requests_admin_list.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_events_header.dart';
import 'package:app/core/presentation/pages/space/widgets/space_event_card/space_event_card.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/graphql/backend/event/query/get_events.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
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
              sort: Input$EventSortInput(
                start: Enum$SortOrder.desc,
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
    final appText = context.theme.appTextTheme;
    final user = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final isAdminOrCreator = widget.space.isAdmin(userId: user?.userId ?? '') ||
        widget.space.isCreator(userId: user?.userId ?? '');
    final appColors = context.theme.appColors;

    return BlocBuilder<GetSpaceEventsBloc, GetSpaceEventsState>(
      builder: (context, state) {
        final events = state.maybeWhen(
          orElse: () => <Event>[],
          success: (events) => events,
        );
        final isLoadingEvents = state.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
        final hasUpcomingEvents = events.any(
          (event) => EventUtils.isLiveOrUpcoming(event),
        );

        return MultiSliver(
          children: [
            if (isAdminOrCreator) ...[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Spacing.s5,
                ),
              ),
              BlocBuilder<GetSpaceEventRequestsBloc,
                  GetSpaceEventRequestsState>(
                builder: (context, state) {
                  final requests = state.maybeWhen(
                    orElse: () => <SpaceEventRequest>[],
                    success: (response) => response.records
                        .where(
                          (request) =>
                              request.state ==
                              Enum$SpaceEventRequestState.pending,
                        )
                        .toList(),
                  );
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.s4,
                      ),
                      child: SpaceEventRequestsAdminList(
                        spaceId: widget.space.id ?? '',
                        requests: requests,
                      ),
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Spacing.s5,
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  height: Spacing.s1_5,
                  thickness: Spacing.s1_5,
                  color: appColors.pageDividerInverse,
                ),
              ),
            ],
            if (!isAdminOrCreator &&
                !hasUpcomingEvents &&
                events.isNotEmpty &&
                !isLoadingEvents) ...[
              SliverPadding(
                padding: EdgeInsets.all(Spacing.s5),
                sliver: SliverToBoxAdapter(
                  child: SpaceNoUpcomingEventsWidget(
                    isSubscriber: widget.space.isFollower(
                      userId: user?.userId ?? '',
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  height: Spacing.s1_5,
                  thickness: Spacing.s1_5,
                  color: appColors.pageDividerInverse,
                ),
              ),
            ],
            SliverToBoxAdapter(
              child: SizedBox(
                height: Spacing.s5,
              ),
            ),
            if (!hasUpcomingEvents && !isLoadingEvents && events.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.s4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.event.pastEvents, style: appText.lg),
                      SizedBox(height: Spacing.s4),
                    ],
                  ),
                ),
              ),
            if (events.isNotEmpty)
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
            if (isLoadingEvents)
              SliverToBoxAdapter(
                child: Center(
                  child: Loading.defaultLoading(context),
                ),
              )
            else if (events.isEmpty)
              const SliverToBoxAdapter(
                child: SpaceEmptyEventsWidget(),
              )
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.s4,
                ),
                sliver: SliverList.separated(
                  addAutomaticKeepAlives: true,
                  itemBuilder: (context, index) {
                    return SpaceEventCard(
                      event: events[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: Spacing.s2);
                  },
                  itemCount: events.length,
                ),
              ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 200),
            ),
          ],
        );
      },
    );
  }
}
