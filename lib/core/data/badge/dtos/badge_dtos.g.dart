// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BadgeDto _$$_BadgeDtoFromJson(Map<String, dynamic> json) => _$_BadgeDto(
      id: json['_id'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      claimable: json['claimable'] as bool?,
      distance: (json['distance'] as num?)?.toDouble(),
      list: json['list'] as String?,
      listExpanded: json['list_expanded'] == null
          ? null
          : BadgeListDto.fromJson(
              json['list_expanded'] as Map<String, dynamic>),
      contract: json['contract'] as String?,
      network: json['network'] as String?,
    );

Map<String, dynamic> _$$_BadgeDtoToJson(_$_BadgeDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'city': instance.city,
      'country': instance.country,
      'claimable': instance.claimable,
      'distance': instance.distance,
      'list': instance.list,
      'list_expanded': instance.listExpanded?.toJson(),
      'contract': instance.contract,
      'network': instance.network,
    };

_$_BadgeListDto _$$_BadgeListDtoFromJson(Map<String, dynamic> json) =>
    _$_BadgeListDto(
      id: json['_id'] as String?,
      imageUrl: json['image_url'] as String?,
      title: json['title'] as String?,
      user: json['user'] as String?,
      userExpanded: json['userExpanded'] == null
          ? null
          : UserDto.fromJson(json['userExpanded'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BadgeListDtoToJson(_$_BadgeListDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'image_url': instance.imageUrl,
      'title': instance.title,
      'user': instance.user,
      'userExpanded': instance.userExpanded?.toJson(),
    };

_$_BadgeCityDto _$$_BadgeCityDtoFromJson(Map<String, dynamic> json) =>
    _$_BadgeCityDto(
      city: json['city'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$_BadgeCityDtoToJson(_$_BadgeCityDto instance) =>
    <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
    };
