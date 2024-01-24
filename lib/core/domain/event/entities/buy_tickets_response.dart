import 'package:app/core/data/event/dtos/buy_tickets_response_dto/buy_tickets_response_dto.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_tickets_response.freezed.dart';

@freezed
class BuyTicketsResponse with _$BuyTicketsResponse {
  BuyTicketsResponse._();

  factory BuyTicketsResponse({
    EventJoinRequest? eventJoinRequest,
    Payment? payment,
  }) = _BuyTicketsResponse;

  factory BuyTicketsResponse.fromDto(BuyTicketsResponseDto dto) =>
      BuyTicketsResponse(
        eventJoinRequest: dto.eventJoinRequest != null
            ? EventJoinRequest.fromDto(dto.eventJoinRequest!)
            : null,
        payment: dto.payment != null ? Payment.fromDto(dto.payment!) : null,
      );
}
