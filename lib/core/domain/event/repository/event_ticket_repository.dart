import 'package:app/core/domain/event/entities/event_ticket_pricing.dart';
import 'package:app/core/domain/event/input/get_event_ticket_pricing_input/get_event_ticket_pricing_input.dart';
import 'package:app/core/domain/event/input/redeem_event_ticket_input/redeem_event_ticket_input.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class EventTicketRepository {
  Future<Either<Failure, EventTicketPricing>> getEventTicketPricing({
    required GetEventTicketPricingInput input,
  });

  Future<Either<Failure, Payment>> redeemEventTickets({
    required RedeemEventTicketInput input,
  });
}
