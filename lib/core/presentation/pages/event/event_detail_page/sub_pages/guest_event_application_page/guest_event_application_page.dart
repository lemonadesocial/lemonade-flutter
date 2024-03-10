import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_application_form_bloc/event_application_form_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/domain/event/entities/event.dart' as event_entity;
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class GuestEventApplicationPage extends StatelessWidget
    implements AutoRouteWrapper {
  const GuestEventApplicationPage({
    super.key,
    required this.event,
  });
  final event_entity.Event event;

  @override
  Widget wrappedRoute(BuildContext context) {
    final user = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession,
          orElse: () => null,
        );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventProviderBloc(event: event),
        ),
        BlocProvider(
          create: (context) => EventApplicationFormBloc()
            ..add(
              EventApplicationFormBlocEvent.initFieldState(
                event: event,
                user: user,
              ),
            ),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
