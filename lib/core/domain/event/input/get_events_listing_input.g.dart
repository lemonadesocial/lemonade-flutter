// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_events_listing_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetEventsInput _$$_GetEventsInputFromJson(Map<String, dynamic> json) =>
    _$_GetEventsInput(
      query: json['query'] as String? ?? '',
      highlight: json['highlight'] as bool? ?? false,
      accepted: json['accepted'] as String? ?? '',
      limit: json['limit'] as int? ?? 100,
      skip: json['skip'] as int? ?? 0,
    );

Map<String, dynamic> _$$_GetEventsInputToJson(_$_GetEventsInput instance) =>
    <String, dynamic>{
      'query': instance.query,
      'highlight': instance.highlight,
      'accepted': instance.accepted,
      'limit': instance.limit,
      'skip': instance.skip,
    };

_$_GetHomeEventsInput _$$_GetHomeEventsInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetHomeEventsInput(
      query: json['query'] as String? ?? '',
      limit: json['limit'] as int? ?? 100,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      tense: $enumDecodeNullable(_$EventTenseEnumMap, json['tense']) ??
          EventTense.Future,
    );

Map<String, dynamic> _$$_GetHomeEventsInputToJson(
        _$_GetHomeEventsInput instance) =>
    <String, dynamic>{
      'query': instance.query,
      'limit': instance.limit,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'tense': _$EventTenseEnumMap[instance.tense]!,
    };

const _$EventTenseEnumMap = {
  EventTense.Current: 'Current',
  EventTense.Future: 'Future',
  EventTense.Past: 'Past',
};

_$_GetHostingEventsInput _$$_GetHostingEventsInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetHostingEventsInput(
      id: json['id'] as String,
      state: json['state'] == null
          ? null
          : FilterEventInput.fromJson(json['state'] as Map<String, dynamic>),
      limit: json['limit'] as int? ?? 100,
      skip: json['skip'] ?? 0,
      order: json['order'] ?? -1,
    );

Map<String, dynamic> _$$_GetHostingEventsInputToJson(
        _$_GetHostingEventsInput instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'limit': instance.limit,
      'skip': instance.skip,
      'order': instance.order,
    };

_$_FilterEventInput _$$_FilterEventInputFromJson(Map<String, dynamic> json) =>
    _$_FilterEventInput(
      eq: $enumDecodeNullable(_$EventStateEnumMap, json['eq']),
      include: (json['in'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$EventStateEnumMap, e))
          .toList(),
      notInclude: (json['nin'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$EventStateEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$$_FilterEventInputToJson(_$_FilterEventInput instance) =>
    <String, dynamic>{
      'eq': _$EventStateEnumMap[instance.eq],
      'in': instance.include?.map((e) => _$EventStateEnumMap[e]!).toList(),
      'nin': instance.notInclude?.map((e) => _$EventStateEnumMap[e]!).toList(),
    };

const _$EventStateEnumMap = {
  EventState.created: 'created',
  EventState.started: 'started',
  EventState.ended: 'ended',
  EventState.cancelled: 'cancelled',
};
