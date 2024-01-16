import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/input/get_event_ticket_types_input/get_event_ticket_types_input.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/input/redeem_tickets_input/redeem_tickets_input.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/event/mutation/create_event_ticket_type.graphql.dart';
import 'package:app/graphql/backend/event/mutation/update_event_ticket_type.graphql.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class EventTicketRepository {
  Future<Either<Failure, EventTicketsPricingInfo>> calculateTicketsPricing({
    required CalculateTicketsPricingInput input,
  });

  Future<Either<Failure, EventTicketTypesResponse>> getEventTicketTypes({
    required GetEventTicketTypesInput input,
  });

  Future<Either<Failure, List<EventTicket>>> redeemTickets({
    required RedeemTicketsInput input,
  });

  Future<Either<Failure, bool>> assignTickets({
    required AssignTicketsInput input,
  });

  Future<Either<Failure, List<EventTicket>>> getTickets({
    required GetTicketsInput input,
  });

  Future<Either<Failure, Payment?>> buyTickets({
    required BuyTicketsInput input,
  });

  Future<Either<Failure, List<EventCurrency>>> getEventCurrencies({
    required GetEventCurrenciesInput input,
    FetchPolicy? fetchPolicy,
  });

  Future<Either<Failure, EventTicketType>> createEventTicketType({
    required Variables$Mutation$CreateEventTicketType input,
  });

  Future<Either<Failure, EventTicketType>> updateEventTicketType({
    required Variables$Mutation$UpdateEventTicketType input,
  });
}
