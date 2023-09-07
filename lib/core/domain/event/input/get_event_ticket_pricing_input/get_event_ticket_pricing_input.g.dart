// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_event_ticket_pricing_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetEventTicketPricingInput _$$_GetEventTicketPricingInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetEventTicketPricingInput(
      event: json['event'] as String,
      type: json['type'] as String?,
      discount: json['discount'] as String?,
    );

Map<String, dynamic> _$$_GetEventTicketPricingInputToJson(
    _$_GetEventTicketPricingInput instance) {
  final val = <String, dynamic>{
    'event': instance.event,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('discount', instance.discount);
  return val;
}
