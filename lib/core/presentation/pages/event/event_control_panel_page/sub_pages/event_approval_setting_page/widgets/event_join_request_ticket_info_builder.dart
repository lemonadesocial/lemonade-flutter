import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';

class EventJoinRequestTicketInfoBuilder extends StatelessWidget {
  final Widget Function({
    required int totalTicketCount,
    required String displayedTotalCost,
    required bool isLoading,
  }) builder;
  final EventJoinRequest eventJoinRequest;

  const EventJoinRequestTicketInfoBuilder({
    super.key,
    required this.builder,
    required this.eventJoinRequest,
  });

  int get totalTicketCount => (eventJoinRequest.ticketInfo ?? [])
      .map((item) => item.count ?? 0)
      .reduce((a, b) => a + b)
      .toInt();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt<EventTicketRepository>().getEventCurrencies(
        input: GetEventCurrenciesInput(
          id: eventJoinRequest.eventExpanded?.id ?? '',
        ),
      ),
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        return builder(
          totalTicketCount: totalTicketCount,
          displayedTotalCost: '',
          isLoading: isLoading,
        );
      },
    );
  }
}
