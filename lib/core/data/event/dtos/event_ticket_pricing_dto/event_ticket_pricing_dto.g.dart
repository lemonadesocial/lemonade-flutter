// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_ticket_pricing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventTicketPricingDto _$$_EventTicketPricingDtoFromJson(
        Map<String, dynamic> json) =>
    _$_EventTicketPricingDto(
      id: json['_id'],
      amount: (json['amount'] as num?)?.toDouble(),
      currency: $enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
    );

Map<String, dynamic> _$$_EventTicketPricingDtoToJson(
        _$_EventTicketPricingDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'amount': instance.amount,
      'currency': _$CurrencyEnumMap[instance.currency],
    };

const _$CurrencyEnumMap = {
  Currency.AUD: 'AUD',
  Currency.CAD: 'CAD',
  Currency.EUR: 'EUR',
  Currency.GBP: 'GBP',
  Currency.INR: 'INR',
  Currency.USD: 'USD',
};
