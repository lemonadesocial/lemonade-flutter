import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/domain/event/entities/event.dart';
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
    User? user,
    User? declinedBy,
    User? approvedBy,
    PaymentBase? payment,
    Event? event,
  }) = _EventJoinRequest;

  factory EventJoinRequest.fromDto(EventJoinRequestDto dto) => EventJoinRequest(
        id: dto.id,
        createdAt: dto.createdAt,
        approvedAt: dto.approvedAt,
        declinedAt: dto.declinedAt,
        user: dto.user != null ? User.fromDto(dto.user!) : null,
        declinedBy:
            dto.declinedBy != null ? User.fromDto(dto.declinedBy!) : null,
        approvedBy:
            dto.approvedBy != null ? User.fromDto(dto.approvedBy!) : null,
        payment: dto.payment != null ? PaymentBase.fromDto(dto.payment!) : null,
        event: dto.event != null ? Event.fromDto(dto.event!) : null,
      );
}
