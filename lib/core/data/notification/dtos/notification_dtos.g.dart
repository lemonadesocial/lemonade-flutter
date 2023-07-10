// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationDto _$$_NotificationDtoFromJson(Map<String, dynamic> json) =>
    _$_NotificationDto(
      id: json['id'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$_NotificationDtoToJson(_$_NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'type': instance.type,
    };
