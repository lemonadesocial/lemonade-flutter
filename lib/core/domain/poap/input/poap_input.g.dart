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

_$_ClaimInput _$$_ClaimInputFromJson(Map<String, dynamic> json) =>
    _$_ClaimInput(
      network: json['network'] as String,
      address: json['address'] as String,
      input: json['input'] == null
          ? null
          : ClaimArgsInput.fromJson(json['input'] as Map<String, dynamic>),
      to: json['to'] as String?,
    );

Map<String, dynamic> _$$_ClaimInputToJson(_$_ClaimInput instance) {
  final val = <String, dynamic>{
    'network': instance.network,
    'address': instance.address,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('input', instance.input?.toJson());
  writeNotNull('to', instance.to);
  return val;
}

_$_ClaimArgsInput _$$_ClaimArgsInputFromJson(Map<String, dynamic> json) =>
    _$_ClaimArgsInput(
      claimer: json['claimer'] as String?,
      tokenURI: json['tokenURI'] as String?,
    );

Map<String, dynamic> _$$_ClaimArgsInputToJson(_$_ClaimArgsInput instance) =>
    <String, dynamic>{
      'claimer': instance.claimer,
      'tokenURI': instance.tokenURI,
    };

_$_GetPoapPolicyInput _$$_GetPoapPolicyInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetPoapPolicyInput(
      network: json['network'] as String,
      address: json['address'] as String,
      target: json['target'] as String?,
    );

Map<String, dynamic> _$$_GetPoapPolicyInputToJson(
    _$_GetPoapPolicyInput instance) {
  final val = <String, dynamic>{
    'network': instance.network,
    'address': instance.address,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('target', instance.target);
  return val;
}
