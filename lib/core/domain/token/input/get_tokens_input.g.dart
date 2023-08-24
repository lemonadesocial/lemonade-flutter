// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_tokens_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetTokensInput _$$_GetTokensInputFromJson(Map<String, dynamic> json) =>
    _$_GetTokensInput(
      owner: json['owner'] as String?,
      ownerIn: (json['owner_in'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tokenId: json['tokenId'] as String?,
      contract: json['contract'] as String?,
      id: json['id'] as String?,
      idIn: (json['id_in'] as List<dynamic>?)?.map((e) => e as String).toList(),
      creator: json['creator'] as String?,
      network: json['network'] as String?,
      skip: json['skip'] as int? ?? 0,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$$_GetTokensInputToJson(_$_GetTokensInput instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('owner', instance.owner);
  writeNotNull('owner_in', instance.ownerIn);
  writeNotNull('tokenId', instance.tokenId);
  writeNotNull('contract', instance.contract);
  writeNotNull('id', instance.id);
  writeNotNull('id_in', instance.idIn);
  writeNotNull('creator', instance.creator);
  writeNotNull('network', instance.network);
  val['skip'] = instance.skip;
  writeNotNull('limit', instance.limit);
  return val;
}

_$_GetTokenDetailInput _$$_GetTokenDetailInputFromJson(
        Map<String, dynamic> json) =>
    _$_GetTokenDetailInput(
      id: json['id'] as String,
      network: json['network'] as String?,
    );

Map<String, dynamic> _$$_GetTokenDetailInputToJson(
    _$_GetTokenDetailInput instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('network', instance.network);
  return val;
}
