import 'package:app/core/data/event/dtos/event_dtos.dart';
import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_join_request_dto.freezed.dart';
part 'event_join_request_dto.g.dart';

@freezed
class EventJoinRequestDto with _$EventJoinRequestDto {
  factory EventJoinRequestDto({
    String? id,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'approved_at') DateTime? approvedAt,
    @JsonKey(name: 'declined_at') DateTime? declinedAt,
    UserDto? user,
    @JsonKey(name: 'declined_by') UserDto? declinedBy,
    @JsonKey(name: 'approved_by') UserDto? approvedBy,
    PaymentBaseDto? payment,
    EventDto? event,
  }) = _EventJoinRequestDto;

  factory EventJoinRequestDto.fromJson(Map<String, dynamic> json) =>
      _$EventJoinRequestDtoFromJson(json);
}
