// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_event_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AcceptEventInput _$$_AcceptEventInputFromJson(Map<String, dynamic> json) =>
    _$_AcceptEventInput(
      id: json['_id'] as String,
      skipPayment: json['skip_payment'] as bool? ?? true,
    );

Map<String, dynamic> _$$_AcceptEventInputToJson(_$_AcceptEventInput instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('skip_payment', instance.skipPayment);
  return val;
}
