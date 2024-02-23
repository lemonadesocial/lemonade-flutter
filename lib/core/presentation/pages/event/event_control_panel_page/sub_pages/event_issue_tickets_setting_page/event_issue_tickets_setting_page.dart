import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event_tickets/issue_tickets_bloc/issue_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventIssueTicketsSettingPage extends StatelessWidget
    implements AutoRouteWrapper {
  const EventIssueTicketsSettingPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    List<EventTicketType> eventTicketTypes =
        context.read<GetEventDetailBloc>().state.maybeWhen(
                  orElse: () => [],
                  fetched: (event) => event.eventTicketTypes,
                ) ??
            [];
    return BlocProvider(
      create: (context) => IssueTicketsBloc()
        ..add(
          IssueTicketsBlocEvent.selectTicketType(
            ticketType: eventTicketTypes.firstOrNull,
          ),
        ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
