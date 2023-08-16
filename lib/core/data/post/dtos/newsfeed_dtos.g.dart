// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsfeed_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NewsfeedDto _$$_NewsfeedDtoFromJson(Map<String, dynamic> json) =>
    _$_NewsfeedDto(
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => PostDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      offset: json['offset'] as int?,
    );

Map<String, dynamic> _$$_NewsfeedDtoToJson(_$_NewsfeedDto instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'offset': instance.offset,
    };
