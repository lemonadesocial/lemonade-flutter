import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_buy_tickets_prerequisite_check_bloc/event_buy_tickets_prerequisite_check_bloc.dart';
import 'package:app/core/application/event/get_event_checkins_bloc/get_event_checkins_bloc.dart';
import 'package:app/core/application/event/get_event_cohost_requests_bloc/get_event_cohost_requests_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_pending_invites_bloc/get_event_pending_invites_bloc.dart';
import 'package:app/core/application/event_tickets/generate_event_invitation_url_bloc/generate_event_invitation_url_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const EventDetailPage({
    super.key,
    @PathParam('id') required this.eventId,
  });
  final String eventId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetEventDetailBloc()
            ..add(
              GetEventDetailEvent.fetch(
                eventId: eventId,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => EditEventDetailBloc(),
        ),
        BlocProvider(
          create: (context) => EventBuyTicketsPrerequisiteCheckBloc(),
        ),

        BlocProvider(
          create: (context) => GetEventCohostRequestsBloc()
            ..add(
              GetEventCohostRequestsEvent.fetch(
                eventId: eventId,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetEventCheckinsBloc()
            ..add(
              GetEventCheckinsEvent.fetch(
                eventId: eventId,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GenerateEventInvitationUrlBloc()
            ..add(
              GenerateEventInvitationUrlEvent.generate(
                eventId: eventId,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetEventPendingInvitesBloc()
            ..add(
              const GetEventPendingInvitesEvent.fetch(),
            ),
        ),
        // BlocProvider(
        //   create: (context) => GetEventUserRoleBloc()
        //     ..add(
        //       GetEventUserRoleEvent.fetch(
        //         eventId: eventId,
        //         userId: userId,
        //       ),
        //     ),
        // ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: const AutoRouter(),
    );
  }
}
