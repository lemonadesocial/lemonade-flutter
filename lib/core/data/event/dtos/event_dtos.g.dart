// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventDto _$$_EventDtoFromJson(Map<String, dynamic> json) => _$_EventDto(
      id: json['_id'] as String?,
      hostExpanded: json['host_expanded'] == null
          ? null
          : UserDto.fromJson(json['host_expanded'] as Map<String, dynamic>),
      newNewPhotosExpanded: (json['new_new_photos_expanded'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : DbFileDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      cohosts:
          (json['cohosts'] as List<dynamic>?)?.map((e) => e as String).toList(),
      cohostsExpanded: (json['cohosts_expanded'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : UserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      speakerUsers: (json['speaker_users'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      host: json['host'] as String?,
      broadcasts: (json['broadcasts'] as List<dynamic>?)
          ?.map((e) => BroadcastDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      cost: (json['cost'] as num?)?.toDouble(),
      currency: $enumDecodeNullable(_$CurrencyEnumMap, json['currency']),
      accepted: (json['accepted'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      invited:
          (json['invited'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pending:
          (json['pending'] as List<dynamic>?)?.map((e) => e as String).toList(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_EventDtoToJson(_$_EventDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'host_expanded': instance.hostExpanded?.toJson(),
      'new_new_photos_expanded':
          instance.newNewPhotosExpanded?.map((e) => e?.toJson()).toList(),
      'cohosts': instance.cohosts,
      'cohosts_expanded':
          instance.cohostsExpanded?.map((e) => e?.toJson()).toList(),
      'title': instance.title,
      'slug': instance.slug,
      'speaker_users': instance.speakerUsers,
      'host': instance.host,
      'broadcasts': instance.broadcasts?.map((e) => e.toJson()).toList(),
      'description': instance.description,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'cost': instance.cost,
      'currency': _$CurrencyEnumMap[instance.currency],
      'accepted': instance.accepted,
      'invited': instance.invited,
      'pending': instance.pending,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

const _$CurrencyEnumMap = {
  Currency.AUD: 'AUD',
  Currency.CAD: 'CAD',
  Currency.EUR: 'EUR',
  Currency.GBP: 'GBP',
  Currency.INR: 'INR',
  Currency.USD: 'USD',
};

_$_BroadcastDto _$$_BroadcastDtoFromJson(Map<String, dynamic> json) =>
    _$_BroadcastDto(
      providerId: json['provider_id'] as String?,
    );

Map<String, dynamic> _$$_BroadcastDtoToJson(_$_BroadcastDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('provider_id', instance.providerId);
  return val;
}
