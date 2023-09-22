import 'package:app/core/domain/event/entities/event_list_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_ticket_pricing.dart';
import 'package:app/core/domain/event/input/get_event_list_ticket_types_input/get_event_list_ticket_types_input.dart';
import 'package:app/core/domain/event/input/get_event_ticket_pricing_input/get_event_ticket_pricing_input.dart';
import 'package:app/core/domain/event/input/redeem_tickets_input/redeem_tickets_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventTicketRepository {
  Future<Either<Failure, EventTicketPricing>> getEventTicketPricing({
    required GetEventTicketPricingInput input,
  });

  Future<Either<Failure, EventListTicketTypes>> getEventListTicketTypes({
    required GetEventListTicketTypesInput input,
  });

  Future<Either<Failure, List<EventTicket>>> redeemTickets({
    required RedeemTicketsInput input,
  });
}
