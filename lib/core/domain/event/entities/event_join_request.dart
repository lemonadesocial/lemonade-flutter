import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
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
    Payment? payment,
    String? event,
  }) = _EventJoinRequest;

  factory EventJoinRequest.fromDto(EventJoinRequestDto dto) => EventJoinRequest(
        id: dto.id,
        createdAt: dto.createdAt,
        approvedAt: dto.approvedAt,
        declinedAt: dto.declinedAt,
        user: dto.user,
        declinedBy: dto.declinedBy,
        approvedBy: dto.approvedBy,
        payment: dto.payment != null ? Payment.fromDto(dto.payment!) : null,
        event: dto.event,
      );
}
