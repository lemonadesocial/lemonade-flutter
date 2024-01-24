import 'package:app/core/data/event/dtos/event_join_request_dto/event_join_request_dto.dart';
import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_tickets_response_dto.freezed.dart';
part 'buy_tickets_response_dto.g.dart';

@freezed
class BuyTicketsResponseDto with _$BuyTicketsResponseDto {
  factory BuyTicketsResponseDto({
    @JsonKey(name: 'event_join_request') EventJoinRequestDto? eventJoinRequest,
    PaymentDto? payment,
  }) = _BuyTicketsResponseDto;

  factory BuyTicketsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BuyTicketsResponseDtoFromJson(json);
}
