// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetBadgesInput _$$_GetBadgesInputFromJson(Map<String, dynamic> json) =>
    _$_GetBadgesInput(
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
      list: (json['list'] as List<dynamic>?)?.map((e) => e as String).toList(),
      id: (json['_id'] as List<dynamic>?)?.map((e) => e as String).toList(),
      city: json['city'] as String?,
      country: json['country'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_GetBadgesInputToJson(_$_GetBadgesInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('skip', instance.skip);
  writeNotNull('limit', instance.limit);
  writeNotNull('list', instance.list);
  writeNotNull('_id', instance.id);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.country);
  writeNotNull('distance', instance.distance);
  return val;
}

_$_GetBadgeListsInput _$$_GetBadgeListsInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetBadgeListsInput(
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
      user: json['user'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$_GetBadgeListsInputToJson(
    _$_GetBadgeListsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('skip', instance.skip);
  writeNotNull('limit', instance.limit);
  writeNotNull('user', instance.user);
  writeNotNull('title', instance.title);
  return val;
}

_$_GetBadgeCitiesInput _$$_GetBadgeCitiesInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetBadgeCitiesInput(
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
      user: json['user'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$_GetBadgeCitiesInputToJson(
    _$_GetBadgeCitiesInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('skip', instance.skip);
  writeNotNull('limit', instance.limit);
  writeNotNull('user', instance.user);
  writeNotNull('title', instance.title);
  return val;
}
