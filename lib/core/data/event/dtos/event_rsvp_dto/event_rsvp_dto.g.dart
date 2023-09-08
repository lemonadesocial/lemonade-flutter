// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_rsvp_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventRSVPDto _$$_EventRSVPDtoFromJson(Map<String, dynamic> json) =>
    _$_EventRSVPDto(
      id: json['_id'] as String?,
      messages: json['messages'] == null
          ? null
          : EventRsvpMessagesDto.fromJson(
              json['messages'] as Map<String, dynamic>),
      payment: json['payment'] == null
          ? null
          : EventRsvpPaymentDto.fromJson(
              json['payment'] as Map<String, dynamic>),
      state: $enumDecodeNullable(_$EventRsvpStateEnumMap, json['state']),
    );

Map<String, dynamic> _$$_EventRSVPDtoToJson(_$_EventRSVPDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'messages': instance.messages?.toJson(),
      'payment': instance.payment?.toJson(),
      'state': _$EventRsvpStateEnumMap[instance.state],
    };

const _$EventRsvpStateEnumMap = {
  EventRsvpState.accepted: 'accepted',
  EventRsvpState.declined: 'declined',
  EventRsvpState.payment: 'payment',
  EventRsvpState.pending: 'pending',
};

_$_EventRsvpMessagesDto _$$_EventRsvpMessagesDtoFromJson(
        Map<String, dynamic> json) =>
    _$_EventRsvpMessagesDto(
      primary: json['primary'] as String?,
      secondary: json['secondary'] as String?,
    );

Map<String, dynamic> _$$_EventRsvpMessagesDtoToJson(
        _$_EventRsvpMessagesDto instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'secondary': instance.secondary,
    };

_$_EventRsvpPaymentDto _$$_EventRsvpPaymentDtoFromJson(
        Map<String, dynamic> json) =>
    _$_EventRsvpPaymentDto(
      amount: (json['amount'] as num?)?.toDouble(),
      currency: $enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
      provider: json['provider'] as String?,
    );

Map<String, dynamic> _$$_EventRsvpPaymentDtoToJson(
        _$_EventRsvpPaymentDto instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': _$CurrencyEnumMap[instance.currency],
      'provider': instance.provider,
    };

const _$CurrencyEnumMap = {
  Currency.AUD: 'AUD',
  Currency.CAD: 'CAD',
  Currency.EUR: 'EUR',
  Currency.GBP: 'GBP',
  Currency.INR: 'INR',
  Currency.USD: 'USD',
};
