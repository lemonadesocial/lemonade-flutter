// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentDto _$$_PaymentDtoFromJson(Map<String, dynamic> json) =>
    _$_PaymentDto(
      id: json['_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: $enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
    );

Map<String, dynamic> _$$_PaymentDtoToJson(_$_PaymentDto instance) =>
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
