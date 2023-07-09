// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_events_listing_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetEventsInput _$$_GetEventsInputFromJson(Map<String, dynamic> json) =>
    _$_GetEventsInput(
      search: json['search'] as String?,
      highlight: json['highlight'] as bool?,
      accepted: json['accepted'] as String?,
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$$_GetEventsInputToJson(_$_GetEventsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('search', instance.search);
  writeNotNull('highlight', instance.highlight);
  writeNotNull('accepted', instance.accepted);
  writeNotNull('skip', instance.skip);
  writeNotNull('limit', instance.limit);
  return val;
}

_$_GetHomeEventsInput _$$_GetHomeEventsInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetHomeEventsInput(
      query: json['query'] as String?,
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      tense: $enumDecodeNullable(_$EventTenseEnumMap, json['tense']) ??
          EventTense.Future,
    );

Map<String, dynamic> _$$_GetHomeEventsInputToJson(
    _$_GetHomeEventsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('query', instance.query);
  writeNotNull('skip', instance.skip);
  writeNotNull('limit', instance.limit);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  val['tense'] = _$EventTenseEnumMap[instance.tense]!;
  return val;
}

const _$EventTenseEnumMap = {
  EventTense.Current: 'Current',
  EventTense.Future: 'Future',
  EventTense.Past: 'Past',
};

_$_GetHostingEventsInput _$$_GetHostingEventsInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetHostingEventsInput(
      id: json['id'] as String?,
      state: json['state'] == null
          ? null
          : FilterEventInput.fromJson(json['state'] as Map<String, dynamic>),
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
      order: json['order'] ?? -1,
    );

Map<String, dynamic> _$$_GetHostingEventsInputToJson(
    _$_GetHostingEventsInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('state', instance.state);
  writeNotNull('skip', instance.skip);
  writeNotNull('limit', instance.limit);
  val['order'] = instance.order;
  return val;
}

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

Map<String, dynamic> _$$_FilterEventInputToJson(_$_FilterEventInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('eq', _$EventStateEnumMap[instance.eq]);
  writeNotNull(
      'in', instance.include?.map((e) => _$EventStateEnumMap[e]!).toList());
  writeNotNull(
      'nin', instance.notInclude?.map((e) => _$EventStateEnumMap[e]!).toList());
  return val;
}

const _$EventStateEnumMap = {
  EventState.created: 'created',
  EventState.started: 'started',
  EventState.ended: 'ended',
  EventState.cancelled: 'cancelled',
};
