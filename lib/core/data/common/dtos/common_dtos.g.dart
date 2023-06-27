// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddressDto _$$_AddressDtoFromJson(Map<String, dynamic> json) =>
    _$_AddressDto(
      street1: json['street1'] as String?,
      street2: json['street2'] as String?,
      city: json['city'] as String?,
      region: json['region'] as String?,
      postal: json['postal'] as String?,
      country: json['country'] as String?,
      title: json['title'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      recipientName: json['recipient_name'] as String?,
    );

Map<String, dynamic> _$$_AddressDtoToJson(_$_AddressDto instance) {
  final val = <String, dynamic>{
    'street1': instance.street1,
    'street2': instance.street2,
    'city': instance.city,
    'region': instance.region,
    'postal': instance.postal,
    'country': instance.country,
    'title': instance.title,
    'latitude': instance.latitude,
    'longitude': instance.longitude,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('recipient_name', instance.recipientName);
  return val;
}

_$_DbFileDto _$$_DbFileDtoFromJson(Map<String, dynamic> json) => _$_DbFileDto(
      id: json['_id'] as String?,
      url: json['url'] as String?,
      owner: json['owner'] as String?,
      bucket: json['bucket'] as String?,
      ownerExpanded: json['ownerExpanded'] == null
          ? null
          : UserDto.fromJson(json['ownerExpanded'] as Map<String, dynamic>),
      stamp: json['stamp'] as String?,
      likes: json['likes'] as int?,
      liked: json['liked'] as bool?,
      description: json['description'] as String?,
      key: json['key'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$_DbFileDtoToJson(_$_DbFileDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  val['url'] = instance.url;
  val['owner'] = instance.owner;
  val['bucket'] = instance.bucket;
  val['ownerExpanded'] = instance.ownerExpanded;
  val['stamp'] = instance.stamp;
  val['likes'] = instance.likes;
  val['liked'] = instance.liked;
  val['description'] = instance.description;
  val['key'] = instance.key;
  val['type'] = instance.type;
  return val;
}
