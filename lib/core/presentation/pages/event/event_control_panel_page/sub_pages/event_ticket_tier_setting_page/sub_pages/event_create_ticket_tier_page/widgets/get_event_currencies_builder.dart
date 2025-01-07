import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetEventCurrenciesBuilder extends StatelessWidget {
  final String eventId;
  final Widget Function(
    BuildContext context,
    bool loading,
    List<EventCurrency> currencies,
  ) builder;
  const GetEventCurrenciesBuilder({
    super.key,
    required this.eventId,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => false,
          authenticated: (_) => true,
        );
    return FutureBuilder<Either<Failure, List<EventCurrency>>>(
      future: isLoggedIn
          ? getIt<EventTicketRepository>().getEventCurrencies(
              input: GetEventCurrenciesInput(id: eventId, used: false),
              fetchPolicy: FetchPolicy.networkOnly,
            )
          // ignore: null_argument_to_non_null_type
          : Future.value(null),
      builder: (context, snapshot) {
        final currencies = snapshot.data?.getOrElse(() => []) ?? [];
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        return builder(context, isLoading, currencies);
      },
    );
  }
}
