import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_list_ticket_types_bloc/get_event_list_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventBuyTicketsPage extends StatelessWidget implements AutoRouteWrapper {
  const EventBuyTicketsPage({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventProviderBloc(event: event),
        ),
        BlocProvider(create: (context) => SelectEventTicketTypesBloc()),
        BlocProvider(
          create: (context) => GetEventListTicketTypesResponseBloc(event: event)
            ..add(
              GetEventListTicketTypesResponseEvent.fetch(),
            ),
        )
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
