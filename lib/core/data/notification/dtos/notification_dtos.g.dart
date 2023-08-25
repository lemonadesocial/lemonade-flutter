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
      title: json['title'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      from: json['from'] as String?,
      isSeen: json['isSeen'] as bool?,
      refEvent: json['ref_event'] as String?,
      refRoom: json['ref_room'] as String?,
      refStoreOrder: json['ref_store_order'] as String?,
      refUser: json['ref_user'] as String?,
    );

Map<String, dynamic> _$$_NotificationDtoToJson(_$_NotificationDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'from_expanded': instance.fromExpanded?.toJson(),
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'createdAt': instance.createdAt?.toIso8601String(),
      'from': instance.from,
      'isSeen': instance.isSeen,
      'ref_event': instance.refEvent,
      'ref_room': instance.refRoom,
      'ref_store_order': instance.refStoreOrder,
      'ref_user': instance.refUser,
    };
