// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poap_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransferDto _$$_TransferDtoFromJson(Map<String, dynamic> json) =>
    _$_TransferDto(
      id: json['_id'] as String?,
      network: json['network'] as String?,
      state: $enumDecodeNullable(_$TransferStateEnumMap, json['state']),
      errorMessage: json['errorMessage'] as String?,
      args: json['args'] == null
          ? null
          : TransferArgsDto.fromJson(json['args'] as Map<String, dynamic>),
      address: json['address'] as String?,
      tokenId: json['tokenId'] as String?,
    );

Map<String, dynamic> _$$_TransferDtoToJson(_$_TransferDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'network': instance.network,
      'state': _$TransferStateEnumMap[instance.state],
      'errorMessage': instance.errorMessage,
      'args': instance.args,
      'address': instance.address,
      'tokenId': instance.tokenId,
    };

const _$TransferStateEnumMap = {
  TransferState.PENDING: 'PENDING',
  TransferState.CONFIRMED: 'CONFIRMED',
  TransferState.FAILED: 'FAILED',
};

_$_TransferArgsDto _$$_TransferArgsDtoFromJson(Map<String, dynamic> json) =>
    _$_TransferArgsDto(
      claimer: json['claimer'] as String?,
      tokenURI: json['tokenURI'] as String?,
    );

Map<String, dynamic> _$$_TransferArgsDtoToJson(_$_TransferArgsDto instance) =>
    <String, dynamic>{
      'claimer': instance.claimer,
      'tokenURI': instance.tokenURI,
    };

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

_$_PoapPolicyNodeDto _$$_PoapPolicyNodeDtoFromJson(Map<String, dynamic> json) =>
    _$_PoapPolicyNodeDto(
      value: json['value'] as String,
      children: (json['children'] as List<dynamic>?)
              ?.map(
                  (e) => PoapPolicyNodeDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$_PoapPolicyNodeDtoToJson(
        _$_PoapPolicyNodeDto instance) =>
    <String, dynamic>{
      'value': instance.value,
      'children': instance.children,
    };

_$_PoapPolicyErrorDto _$$_PoapPolicyErrorDtoFromJson(
        Map<String, dynamic> json) =>
    _$_PoapPolicyErrorDto(
      message: json['message'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$$_PoapPolicyErrorDtoToJson(
        _$_PoapPolicyErrorDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'path': instance.path,
    };

_$_PoapPolicyResultDto _$$_PoapPolicyResultDtoFromJson(
        Map<String, dynamic> json) =>
    _$_PoapPolicyResultDto(
      boolean: json['boolean'] as bool?,
      node: json['node'] == null
          ? null
          : PoapPolicyNodeDto.fromJson(json['node'] as Map<String, dynamic>),
      errors: (json['errors'] as List<dynamic>?)
              ?.map(
                  (e) => PoapPolicyErrorDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$$_PoapPolicyResultDtoToJson(
        _$_PoapPolicyResultDto instance) =>
    <String, dynamic>{
      'boolean': instance.boolean,
      'node': instance.node,
      'errors': instance.errors,
    };

_$_PoapPolicyDto _$$_PoapPolicyDtoFromJson(Map<String, dynamic> json) =>
    _$_PoapPolicyDto(
      id: json['_id'] as String?,
      network: json['network'] as String?,
      address: json['address'] as String?,
      node: json['node'] == null
          ? null
          : PoapPolicyNodeDto.fromJson(json['node'] as Map<String, dynamic>),
      result: json['result'] == null
          ? null
          : PoapPolicyResultDto.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PoapPolicyDtoToJson(_$_PoapPolicyDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'network': instance.network,
      'address': instance.address,
      'node': instance.node,
      'result': instance.result,
    };
