import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class GetEventCurrenciesBuilder extends StatelessWidget {
  final String eventId;
  final Widget Function(BuildContext context, List<EventCurrency> currencies)
      builder;
  const GetEventCurrenciesBuilder({
    super.key,
    required this.eventId,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<Failure, List<EventCurrency>>>(
      future: getIt<EventTicketRepository>().getEventCurrencies(
        input: GetEventCurrenciesInput(id: eventId, used: false),
      ),
      builder: (context, snapshot) {
        final currencies = snapshot.data?.getOrElse(() => []) ?? [];
        return builder(context, currencies);
      },
    );
  }
}
