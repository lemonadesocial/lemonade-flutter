import 'package:app/core/application/event/edit_event_detail_bloc/edit_event_detail_bloc.dart';
import 'package:app/core/application/event/event_buy_tickets_prerequisite_check_bloc/event_buy_tickets_prerequisite_check_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_user_role_bloc%20/get_event_user_role_bloc.dart';
import 'package:app/core/application/event/update_event_checkin_bloc/update_event_checkin_bloc.dart';
import 'package:app/core/utils/auth_utils.dart';
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
    final userId = AuthUtils.getUserId(context);
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
          create: (context) => UpdateEventCheckinBloc(),
        ),
        BlocProvider(
          create: (context) => EventBuyTicketsPrerequisiteCheckBloc(),
        ),
        BlocProvider(
          create: (context) => GetEventUserRoleBloc()
            ..add(
              GetEventUserRoleEvent.fetch(
                eventId: eventId,
                userId: userId,
              ),
            ),
        ),
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
