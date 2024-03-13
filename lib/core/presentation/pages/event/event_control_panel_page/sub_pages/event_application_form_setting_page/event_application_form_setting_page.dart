import 'package:app/core/application/event/event_application_form_setting_bloc/event_application_form_setting_bloc.dart';
import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventApplicationFormSettingPage extends StatelessWidget
    implements AutoRouteWrapper {
  const EventApplicationFormSettingPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    Event? event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => null,
        );
    return BlocProvider(
      create: (context) => EventApplicationFormSettingBloc(
          initialQuestions: event?.applicationQuestions ?? []),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
