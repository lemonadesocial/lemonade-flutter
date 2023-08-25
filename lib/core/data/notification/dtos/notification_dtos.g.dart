// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationDto _$$_NotificationDtoFromJson(Map<String, dynamic> json) =>
    _$_NotificationDto(
      id: json['_id'] as String?,
      fromExpanded: json['from_expanded'] == null
          ? null
          : UserDto.fromJson(json['from_expanded'] as Map<String, dynamic>),
      message: json['message'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      from: json['from'] as String?,
      isSeen: json['isSeen'] as bool?,
      object_id: json['object_id'] as String?,
      object_type: json['object_type'] as String?,
    );

Map<String, dynamic> _$$_NotificationDtoToJson(_$_NotificationDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'from_expanded': instance.fromExpanded?.toJson(),
      'message': instance.message,
      'type': instance.type,
      'createdAt': instance.createdAt?.toIso8601String(),
      'from': instance.from,
      'isSeen': instance.isSeen,
      'object_id': instance.object_id,
      'object_type': instance.object_type,
    };
