// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poap_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetPoapViewSupplyInput _$$_GetPoapViewSupplyInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetPoapViewSupplyInput(
      network: json['network'] as String,
      address: json['address'] as String,
      name: json['name'] ?? 'supply',
    );

Map<String, dynamic> _$$_GetPoapViewSupplyInputToJson(
        _$_GetPoapViewSupplyInput instance) =>
    <String, dynamic>{
      'network': instance.network,
      'address': instance.address,
      'name': instance.name,
    };

_$_CheckHasClaimedPoapViewInput _$$_CheckHasClaimedPoapViewInputFromJson(
        Map<String, dynamic> json) =>
    _$_CheckHasClaimedPoapViewInput(
      network: json['network'] as String,
      address: json['address'] as String,
      name: json['name'] ?? 'hasClaimed',
      args: (json['args'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$$_CheckHasClaimedPoapViewInputToJson(
        _$_CheckHasClaimedPoapViewInput instance) =>
    <String, dynamic>{
      'network': instance.network,
      'address': instance.address,
      'name': instance.name,
      'args': instance.args,
    };
