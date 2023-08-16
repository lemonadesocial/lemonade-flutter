// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_newsfeed_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetNewsfeedInput _$$_GetNewsfeedInputFromJson(Map<String, dynamic> json) =>
    _$_GetNewsfeedInput(
      offset: json['offset'] as int?,
    );

Map<String, dynamic> _$$_GetNewsfeedInputToJson(_$_GetNewsfeedInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offset', instance.offset);
  return val;
}

_$_GetNewsfeedCreatedAtInput _$$_GetNewsfeedCreatedAtInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetNewsfeedCreatedAtInput(
      gte: json['gte'] == null ? null : DateTime.parse(json['gte'] as String),
      lte: json['lte'] == null ? null : DateTime.parse(json['lte'] as String),
    );

Map<String, dynamic> _$$_GetNewsfeedCreatedAtInputToJson(
    _$_GetNewsfeedCreatedAtInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('gte', instance.gte?.toIso8601String());
  writeNotNull('lte', instance.lte?.toIso8601String());
  return val;
}
