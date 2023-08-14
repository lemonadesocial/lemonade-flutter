// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_posts_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetPostsInput _$$_GetPostsInputFromJson(Map<String, dynamic> json) =>
    _$_GetPostsInput(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      published: json['published'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : GetPostCreatedAtInput.fromJson(
              json['created_at'] as Map<String, dynamic>),
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$$_GetPostsInputToJson(_$_GetPostsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  writeNotNull('user', instance.user);
  writeNotNull('published', instance.published);
  writeNotNull('created_at', instance.createdAt?.toJson());
  writeNotNull('skip', instance.skip);
  writeNotNull('limit', instance.limit);
  return val;
}

_$_GetPostCreatedAtInput _$$_GetPostCreatedAtInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetPostCreatedAtInput(
      gte: json['gte'] == null ? null : DateTime.parse(json['gte'] as String),
      lte: json['lte'] == null ? null : DateTime.parse(json['lte'] as String),
    );

Map<String, dynamic> _$$_GetPostCreatedAtInputToJson(
    _$_GetPostCreatedAtInput instance) {
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
