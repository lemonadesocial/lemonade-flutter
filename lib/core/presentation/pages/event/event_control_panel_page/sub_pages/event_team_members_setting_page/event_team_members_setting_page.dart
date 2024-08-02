import 'package:app/core/application/event/get_event_roles_bloc/get_event_roles_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventTeamMembersSettingPage extends StatelessWidget
    implements AutoRouteWrapper {
  const EventTeamMembersSettingPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => GetEventRolesBloc()..add(GetEventRolesEvent.fetch()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
