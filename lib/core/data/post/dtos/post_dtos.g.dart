// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostDto _$$_PostDtoFromJson(Map<String, dynamic> json) => _$_PostDto(
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      user: json['user'] as String,
      visibility: $enumDecode(_$PostVisibilityEnumMap, json['visibility']),
      userExpanded: json['user_expanded'] == null
          ? null
          : UserDto.fromJson(json['user_expanded'] as Map<String, dynamic>),
      text: json['text'] as String?,
      refId: json['ref_id'] as String?,
      refType: $enumDecodeNullable(_$PostRefTypeEnumMap, json['ref_type']),
      refEvent: json['ref_event'] == null
          ? null
          : EventDto.fromJson(json['ref_event'] as Map<String, dynamic>),
      refFile: json['ref_file'] == null
          ? null
          : DbFileDto.fromJson(json['ref_file'] as Map<String, dynamic>),
      hasReaction: json['has_reaction'] as bool?,
      reactions: json['reactions'] as int?,
      comments: json['comments'] as int?,
      published: json['published'] as bool?,
    );

Map<String, dynamic> _$$_PostDtoToJson(_$_PostDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'user': instance.user,
      'visibility': _$PostVisibilityEnumMap[instance.visibility]!,
      'user_expanded': instance.userExpanded,
      'text': instance.text,
      'ref_id': instance.refId,
      'ref_type': _$PostRefTypeEnumMap[instance.refType],
      'ref_event': instance.refEvent,
      'ref_file': instance.refFile,
      'has_reaction': instance.hasReaction,
      'reactions': instance.reactions,
      'comments': instance.comments,
      'published': instance.published,
    };

const _$PostVisibilityEnumMap = {
  PostVisibility.PUBLIC: 'PUBLIC',
  PostVisibility.FRIENDS: 'FRIENDS',
  PostVisibility.FOLLOWERS: 'FOLLOWERS',
  PostVisibility.MENTIONS: 'MENTIONS',
};

const _$PostRefTypeEnumMap = {
  PostRefType.EVENT: 'EVENT',
  PostRefType.FILE: 'FILE',
};
