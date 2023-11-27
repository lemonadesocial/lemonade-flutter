import 'package:app/core/data/event/dtos/event_currency_dto/event_currency_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_currency.freezed.dart';

@freezed
class EventCurrency with _$EventCurrency {
  EventCurrency._();

  factory EventCurrency({
    double? decimals,
    String? currency,
    String? network,
  }) = _EventCurrency;

  factory EventCurrency.fromDto(EventCurrencyDto dto) => EventCurrency(
        decimals: dto.decimals,
        currency: dto.currency,
        network: dto.network,
      );
}
