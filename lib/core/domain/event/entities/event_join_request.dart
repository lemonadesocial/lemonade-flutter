import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_join_request.freezed.dart';

@freezed
class EventJoinRequest with _$EventJoinRequest {
  EventJoinRequest._();

  factory EventJoinRequest({
    String? id,
    DateTime? createdAt,
    DateTime? approvedAt,
    DateTime? declinedAt,
    String? user,
    String? declinedBy,
    String? approvedBy,
    User? userExpanded,
    User? declinedByExpanded,
    User? approvedByExpanded,
    Payment? paymentExpanded,
    Event? eventExpanded,
    List<TicketInfo>? ticketInfo,
  }) = _EventJoinRequest;

  factory EventJoinRequest.fromDto(EventJoinRequestDto dto) => EventJoinRequest(
        id: dto.id,
        createdAt: dto.createdAt,
        approvedAt: dto.approvedAt,
        declinedAt: dto.declinedAt,
        user: dto.user,
        declinedBy: dto.declinedBy,
        approvedBy: dto.approvedBy,
        userExpanded:
            dto.userExpanded != null ? User.fromDto(dto.userExpanded!) : null,
        declinedByExpanded: dto.declinedByExpanded != null
            ? User.fromDto(dto.declinedByExpanded!)
            : null,
        approvedByExpanded: dto.approvedByExpanded != null
            ? User.fromDto(dto.approvedByExpanded!)
            : null,
        paymentExpanded: dto.paymentExpanded != null
            ? Payment.fromDto(dto.paymentExpanded!)
            : null,
        eventExpanded: dto.eventExpanded != null
            ? Event.fromDto(dto.eventExpanded!)
            : null,
        ticketInfo: (dto.ticketInfo ?? [])
            .map((item) => TicketInfo.fromDto(item))
            .toList(),
      );

  bool get isPending => approvedBy == null && declinedBy == null;

  bool get isDeclined => declinedBy != null;

  bool get isApproved => approvedBy != null;
}
