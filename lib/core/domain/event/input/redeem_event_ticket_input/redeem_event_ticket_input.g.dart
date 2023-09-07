// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redeem_event_ticket_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RedeemEventTicketInput _$$_RedeemEventTicketInputFromJson(
        Map<String, dynamic> json) =>
    _$_RedeemEventTicketInput(
      event: json['event'] as String,
      count: (json['count'] as num).toDouble(),
      type: json['type'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$_RedeemEventTicketInputToJson(
    _$_RedeemEventTicketInput instance) {
  final val = <String, dynamic>{
    'event': instance.event,
    'count': instance.count,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('address', instance.address);
  return val;
}
