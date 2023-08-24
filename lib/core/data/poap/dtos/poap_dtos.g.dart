// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poap_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClaimDto _$$_ClaimDtoFromJson(Map<String, dynamic> json) => _$_ClaimDto(
      id: json['_id'] as String?,
      network: json['network'] as String?,
      state: $enumDecodeNullable(_$ClaimStateEnumMap, json['state']),
      errorMessage: json['errorMessage'] as String?,
      args: json['args'] == null
          ? null
          : ClaimArgsDto.fromJson(json['args'] as Map<String, dynamic>),
      address: json['address'] as String?,
      tokenId: json['tokenId'] as String?,
    );

Map<String, dynamic> _$$_ClaimDtoToJson(_$_ClaimDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'network': instance.network,
      'state': _$ClaimStateEnumMap[instance.state],
      'errorMessage': instance.errorMessage,
      'args': instance.args,
      'address': instance.address,
      'tokenId': instance.tokenId,
    };

const _$ClaimStateEnumMap = {
  ClaimState.PENDING: 'PENDING',
  ClaimState.CONFIRMED: 'CONFIRMED',
  ClaimState.FAILED: 'FAILED',
};

_$_ClaimArgsDto _$$_ClaimArgsDtoFromJson(Map<String, dynamic> json) =>
    _$_ClaimArgsDto(
      claimer: json['claimer'] as String?,
      tokenURI: json['tokenURI'] as String?,
    );

Map<String, dynamic> _$$_ClaimArgsDtoToJson(_$_ClaimArgsDto instance) =>
    <String, dynamic>{
      'claimer': instance.claimer,
      'tokenURI': instance.tokenURI,
    };
