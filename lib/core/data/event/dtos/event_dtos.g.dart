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
          ?.map((e) => DbFileDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
      slug: json['slug'] as String?,
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
    );

Map<String, dynamic> _$$_EventDtoToJson(_$_EventDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  writeNotNull('host_expanded', instance.hostExpanded?.toJson());
  writeNotNull('new_new_photos_expanded',
      instance.newNewPhotosExpanded?.map((e) => e.toJson()).toList());
  val['title'] = instance.title;
  val['slug'] = instance.slug;
  val['host'] = instance.host;
  val['broadcasts'] = instance.broadcasts?.map((e) => e.toJson()).toList();
  val['description'] = instance.description;
  val['start'] = instance.start?.toIso8601String();
  val['end'] = instance.end?.toIso8601String();
  val['cost'] = instance.cost;
  val['currency'] = _$CurrencyEnumMap[instance.currency];
  return val;
}

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
