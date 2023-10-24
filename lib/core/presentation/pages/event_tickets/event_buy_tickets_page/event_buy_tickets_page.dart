import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/application/payment/payment_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart' as event_entity;
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart';

@RoutePage()
class EventBuyTicketsPage extends StatelessWidget implements AutoRouteWrapper {
  const EventBuyTicketsPage({
    super.key,
    required this.event,
  });

  final event_entity.Event event;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventProviderBloc(event: event),
        ),
        BlocProvider(
          create: (context) => GetEventTicketTypesBloc(event: event)
            ..add(
              GetEventTicketTypesEvent.fetch(),
            ),
        ),
        BlocProvider(
          create: (context) => SelectEventTicketTypesBloc(),
        ),
        BlocProvider(
          create: (context) => PaymentBloc(getIt<PaymentRepository>()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var currentTopRoute = AutoRouter.of(context).topRoute;
        bool? isPopBlocked = currentTopRoute.meta.tryGet('popBlocked');
        return isPopBlocked != null ? !isPopBlocked : true;
      },
      child: const AutoRouter(),
    );
  }
}
