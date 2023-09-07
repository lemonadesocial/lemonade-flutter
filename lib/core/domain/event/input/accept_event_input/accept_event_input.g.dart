// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_event_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AcceptEventInput _$$_AcceptEventInputFromJson(Map<String, dynamic> json) =>
    _$_AcceptEventInput(
      id: json['id'] as String,
      skip: json['skip'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AcceptEventInputToJson(_$_AcceptEventInput instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('skip', instance.skip);
  return val;
}
