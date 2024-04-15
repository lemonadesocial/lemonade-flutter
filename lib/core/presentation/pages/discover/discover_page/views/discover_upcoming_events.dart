import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/home_events_listing_bloc.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/event/event_discover_item.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:app/core/utils/device_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DiscoverUpcomingEvents extends StatelessWidget {
  const DiscoverUpcomingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return MultiSliver(
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: Spacing.xSmall,
            horizontal: Spacing.xSmall,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              t.discover.upcomingEvents,
              style: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => HomeEventListingBloc(
            EventService(getIt<EventRepository>()),
            defaultInput: const GetHomeEventsInput(),
          )..add(
              BaseEventsListingEvent.fetch(),
            ),
          child: const _DiscoverEventsList(),
        ),
      ],
    );
  }
}

class _DiscoverEventsList extends StatelessWidget {
  const _DiscoverEventsList();

  @override
  Widget build(BuildContext context) {
    final isIpad = DeviceUtils.isIpad();
    final height = isIpad ? 240.w : 160.w;
    return BlocBuilder<HomeEventListingBloc, BaseEventsListingState>(
      builder: (context, state) => SliverToBoxAdapter(
        child: SizedBox(
          height: state.maybeWhen(
            fetched: (events, _) {
              final upcomingEvents = events
                  .where(
                    (event) => !date_utils.DateUtils.isPast(event.start),
                  )
                  .toList();
              return upcomingEvents.isEmpty ? 200.w : height;
            },
            failure: () => 200.w,
            orElse: () => height,
          ),
          child: state.when(
            failure: () => EmptyList(
              emptyText: t.common.somethingWrong,
            ),
            loading: () => Loading.defaultLoading(context),
            fetched: (events, _) {
              final upcomingEvents = events
                  .where(
                    (event) => !date_utils.DateUtils.isPast(event.start),
                  )
                  .toList();
              if (upcomingEvents.isEmpty) {
                return EmptyList(
                  emptyText: t.event.empty_home_events(time: ''),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    final eventItem = upcomingEvents[index];
                    AutoRouter.of(context).navigate(
                      EventDetailRoute(
                        eventId: eventItem.id ?? '',
                      ),
                    );
                  },
                  child: EventDiscoverItem(
                    event: upcomingEvents[index],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  width: Spacing.xSmall,
                ),
                itemCount: upcomingEvents.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
