import 'package:app/core/domain/event/entities/event_list_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/domain/event/input/assign_tickets_input/assign_tickets_input.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/event/input/get_event_list_ticket_types_input/get_event_list_ticket_types_input.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/input/redeem_tickets_input/redeem_tickets_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventTicketRepository {
  Future<Either<Failure, EventTicketsPricingInfo>> calculateTicketsPricing({
    required CalculateTicketsPricingInput input,
  });

  Future<Either<Failure, EventListTicketTypesResponse>>
      getEventListTicketTypesResponse({
    required GetEventListTicketTypesResponseInput input,
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
}
