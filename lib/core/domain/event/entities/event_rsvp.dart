import 'package:app/core/data/event/dtos/event_rsvp_dto/event_rsvp_dto.dart';
import 'package:app/core/domain/event/event_enums.dart';

class EventRsvp {
  EventRsvp({
    this.id,
    this.messages,
    this.payment,
    this.state,
  });

  final String? id;
  final EventRsvpMessages? messages;
  final EventRsvpPayment? payment;
  final EventRsvpState? state;

  factory EventRsvp.fromDto(EventRsvpDto dto) => EventRsvp(
        id: dto.id,
        messages: dto.messages != null
            ? EventRsvpMessages.fromDto(dto.messages!)
            : null,
        payment:
            dto.payment != null ? EventRsvpPayment.fromDto(dto.payment!) : null,
        state: dto.state,
      );
}

class EventRsvpMessages {
  EventRsvpMessages({
    this.primary,
    this.secondary,
  });

  final String? primary;
  final String? secondary;

  factory EventRsvpMessages.fromDto(EventRsvpMessagesDto dto) =>
      EventRsvpMessages(
        primary: dto.primary,
        secondary: dto.secondary,
      );
}

class EventRsvpPayment {
  final double? amount;
  final String? currency;
  final String? provider;

  EventRsvpPayment({
    this.amount,
    this.currency,
    this.provider,
  });

  factory EventRsvpPayment.fromDto(EventRsvpPaymentDto dto) => EventRsvpPayment(
        amount: dto.amount,
        currency: dto.currency,
        provider: dto.provider,
      );
}
