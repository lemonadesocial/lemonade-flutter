import 'package:app/core/data/event/dtos/event_payment_dto/event_payment_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';

class EventPayment {
  final String? id;
  final String? ticketType;
  final double? ticketCount;
  final double? ticketCountRemaining;
  final String? ticketDiscount;
  final double? ticketDiscountAmount;
  final List<User>? ticketAssigneesExpanded;
  final List<String>? ticketAssignedEmails;
  final Event? eventExpanded;

  EventPayment({
    this.id,
    this.ticketType,
    this.ticketCount,
    this.ticketCountRemaining,
    this.ticketDiscount,
    this.ticketDiscountAmount,
    this.ticketAssigneesExpanded,
    this.ticketAssignedEmails,
    this.eventExpanded,
  });

  factory EventPayment.fromDto(EventPaymentDto dto) => EventPayment(
        id: dto.id,
        ticketType: dto.ticketType,
        ticketCount: dto.ticketCount,
        ticketCountRemaining: dto.ticketCountRemaining,
        ticketDiscount: dto.ticketDiscount,
        ticketDiscountAmount: dto.ticketDiscountAmount,
        ticketAssigneesExpanded: dto.ticketAssigneesExpanded != null
            ? List.from(dto.ticketAssigneesExpanded ?? [])
                .map((item) => User.fromDto(item))
                .toList()
            : [],
        ticketAssignedEmails: dto.ticketAssignedEmails,
        eventExpanded: dto.eventExpanded != null
            ? Event.fromDto(dto.eventExpanded!)
            : null,
      );
}
