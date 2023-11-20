import 'package:app/core/data/event/dtos/event_currency_dto/event_currency_dto.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_currency.freezed.dart';

@freezed
class EventCurrency with _$EventCurrency {
  EventCurrency._();

  factory EventCurrency({
    double? decimals,
    Currency? currency,
    SupportedPaymentNetwork? network,
  }) = _EventCurrency;

  factory EventCurrency.fromDto(EventCurrencyDto dto) => EventCurrency(
        decimals: dto.decimals,
        currency: dto.currency,
        network: dto.network,
      );
}
