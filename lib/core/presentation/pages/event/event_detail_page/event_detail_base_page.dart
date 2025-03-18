import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_sub_events_by_calendar_bloc/get_sub_events_by_calendar_bloc.dart';
import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/application/token_reward/get_my_event_token_rewards_bloc/get_my_event_token_rewards_bloc.dart';
import 'package:app/core/application/token_reward/list_ticket_token_rewards_bloc/list_ticket_token_rewards_bloc.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/views/post_guest_event_detail_view.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/views/pre_guest_event_detail_view.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/view/host_event_detail_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/application/event/get_event_votings_bloc/get_event_votings_bloc.dart';

@RoutePage()
class EventDetailBasePage extends StatelessWidget {
  const EventDetailBasePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const _EventDetailBasePageView();
  }
}

class _EventDetailBasePageView extends StatelessWidget {
  const _EventDetailBasePageView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<GetEventDetailBloc, GetEventDetailState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          fetched: (event) {
            context.read<EditEventDetailBloc>().add(
                  EditEventDetailEvent.updateParentEvent(
                    parentEventId: event.subeventParent ?? '',
                  ),
                );
          },
        );
      },
      builder: (context, state) => state.when(
        failure: () => Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: const LemonAppBar(),
          body: Center(
            child: EmptyList(
              emptyText: t.common.somethingWrong,
            ),
          ),
        ),
        loading: () => Scaffold(
          appBar: const LemonAppBar(),
          backgroundColor: colorScheme.primary,
          body: Center(
            child: Loading.defaultLoading(context),
          ),
        ),
        fetched: (event) {
          final user = context.watch<AuthBloc>().state.maybeWhen(
                orElse: () => null,
                authenticated: (user) => user,
              );
          final userId = user?.userId ?? '';
          final isCohost = EventUtils.isCohost(
            event: event,
            userId: userId,
          );
          final isAttending =
              EventUtils.isAttending(event: event, userId: userId);
          final isOwnEvent =
              EventUtils.isOwnEvent(event: event, userId: userId);
          if (isOwnEvent || isCohost) {
            // final canUseEventCohosts = FeatureManager(
            //   UserRoleFeatureVisibilityStrategy(
            //     eventUserRole: eventUserRole,
            //     roleCodes: [
            //       Enum$RoleCode.Host,
            //       Enum$RoleCode.Cohost,
            //     ],
            //   ),
            // ).canShowFeature;

            // final canUseCheckIn = FeatureManager(
            //   EventRoleBasedEventFeatureVisibilityStrategy(
            //     eventUserRole: eventUserRole,
            //     featureCodes: [Enum$FeatureCode.CheckIn],
            //   ),
            // ).canShowFeature;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => GetSpaceDetailBloc(
                    getIt<SpaceRepository>(),
                  )..add(
                      GetSpaceDetailEvent.fetch(
                        spaceId: event.space ?? '',
                      ),
                    ),
                ),
              ],
              child: const HostEventDetailView(),
            );
          }
          return isAttending
              ? MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GetSubEventsByCalendarBloc(
                        parentEventId: event.id ?? '',
                      )..add(
                          GetSubEventsByCalendarEvent.fetch(),
                        ),
                    ),
                    BlocProvider(
                      create: (context) => GetMyTicketsBloc(
                        input: GetTicketsInput(
                          event: event.id,
                          user: userId,
                          skip: 0,
                          limit: 100,
                        ),
                      )..add(
                          GetMyTicketsEvent.fetch(),
                        ),
                    ),
                    BlocProvider(
                      create: (context) => GetEventVotingsListBloc()
                        ..add(
                          GetEventVotingsListEvent.fetch(
                            eventId: event.id ?? '',
                          ),
                        ),
                    ),
                    BlocProvider(
                      create: (context) => GetMyEventTokenRewardsBloc()
                        ..add(
                          GetMyEventTokenRewardsEvent.fetch(
                            eventId: event.id ?? '',
                          ),
                        ),
                    ),
                    BlocProvider(
                      create: (context) => GetSpaceDetailBloc(
                        getIt<SpaceRepository>(),
                      )..add(
                          GetSpaceDetailEvent.fetch(spaceId: event.space ?? ''),
                        ),
                    ),
                  ],
                  child: const PostGuestEventDetailView(),
                )
              : MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => ListTicketTokenRewardsBloc()
                        ..add(
                          ListTicketTokenRewardsEvent.fetch(
                            eventId: event.id ?? '',
                            tickets: (event.eventTicketTypes ?? [])
                                .map((e) => e.id ?? '')
                                .toList(),
                          ),
                        ),
                    ),
                    BlocProvider(
                      create: (context) => GetSubEventsByCalendarBloc(
                        parentEventId: event.id ?? '',
                      )..add(
                          GetSubEventsByCalendarEvent.fetch(),
                        ),
                    ),
                    BlocProvider(
                      create: (context) => GetSpaceDetailBloc(
                        getIt<SpaceRepository>(),
                      )..add(
                          GetSpaceDetailEvent.fetch(spaceId: event.space ?? ''),
                        ),
                    ),
                  ],
                  child: const PreGuestEventDetailView(),
                );
        },
      ),
    );
  }
}
