import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:flutter/material.dart';

class EventJoinRequestTicketInfoBuilder extends StatelessWidget {
  final Widget Function({
    required int totalTicketCount,
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

  // TODO: total cost
  // Note: right ticketInfo not returns ticket currency, so finding correct price is impossible right now

  @override
  Widget build(BuildContext context) {
    return builder(totalTicketCount: totalTicketCount);
  }
}
