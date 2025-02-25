import 'package:app/core/domain/event/entities/buy_tickets_response.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_ticket_category.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/entities/get_my_tickets_response.dart';
import 'package:app/core/domain/event/entities/redeem_tickets_response.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/event/input/buy_tickets_input/buy_tickets_input.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/input/get_event_ticket_types_input/get_event_ticket_types_input.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/event/mutation/create_event_ticket_discount.graphql.dart';
import 'package:app/graphql/backend/event/mutation/email_event_ticket.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app/graphql/backend/event/mutation/create_tickets.graphql.dart';
import 'package:app/graphql/backend/event/query/get_my_tickets.graphql.dart';
import 'package:app/core/domain/event/entities/ticket_statistics.dart';

abstract class EventTicketRepository {
  Future<Either<Failure, EventTicketsPricingInfo>> calculateTicketsPricing({
    required CalculateTicketsPricingInput input,
  });

  Future<Either<Failure, EventTicketTypesResponse>> getEventTicketTypes({
    required GetEventTicketTypesInput input,
  });

  Future<Either<Failure, RedeemTicketsResponse>> redeemTickets({
    required Input$RedeemTicketsInput input,
  });

  Future<Either<Failure, bool>> assignTickets({
    required AssignTicketsInput input,
  });

  Future<Either<Failure, GetMyTicketsResponse>> getMyTickets({
    required Variables$Query$GetMyTickets input,
  });

  Future<Either<Failure, List<EventTicket>>> getTickets({
    required GetTicketsInput input,
  });

  Future<Either<Failure, EventTicket>> getTicket({
    required String shortId,
  });

  Future<Either<Failure, BuyTicketsResponse>> buyTickets({
    required BuyTicketsInput input,
  });

  Future<Either<Failure, List<EventCurrency>>> getEventCurrencies({
    required GetEventCurrenciesInput input,
    FetchPolicy? fetchPolicy,
  });

  Future<Either<Failure, EventTicketType>> createEventTicketType({
    required Input$EventTicketTypeInput input,
  });

  Future<Either<Failure, EventTicketType>> updateEventTicketType({
    required Input$EventTicketTypeInput input,
    required String ticketTypeId,
  });

  Future<Either<Failure, bool>> deleteEventTicketType({
    required String ticketTypeId,
    required String eventId,
  });

  Future<Either<Failure, List<EventTicket>>> createTickets({
    required Variables$Mutation$CreateTickets input,
  });

  Future<Either<Failure, EventTicketCategory>> createEventTicketCategory({
    required Input$CreateEventTicketCategoryInput input,
  });

  Future<Either<Failure, bool>> mailEventTicket({
    required Variables$Mutation$MailEventTicket input,
  });

  Future<Either<Failure, String>> createEventDiscounts({
    required Variables$Mutation$CreateEventTicketDiscounts input,
  });

  Future<Either<Failure, bool>> cancelTickets({
    required String eventId,
    required List<String> ticketIds,
  });

  Future<Either<Failure, TicketStatistics>> getTicketStatistics({
    required String eventId,
  });
}
