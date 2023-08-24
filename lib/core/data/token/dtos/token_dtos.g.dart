// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TokenComplexDto _$$_TokenComplexDtoFromJson(Map<String, dynamic> json) =>
    _$_TokenComplexDto(
      id: json['id'] as String,
      network: json['network'] as String,
      tokenId: json['tokenId'] as String,
      registry: RegistryDto.fromJson(json['registry'] as Map<String, dynamic>),
      contract: json['contract'] as String,
      order: json['order'] == null
          ? null
          : OrderSimpleDto.fromJson(json['order'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      creator: json['creator'] as String?,
      creatorExpanded: json['creatorExpanded'] == null
          ? null
          : UserDto.fromJson(json['creatorExpanded'] as Map<String, dynamic>),
      enrichCount: (json['enrichCount'] as num?)?.toDouble(),
      enrichedAt: json['enrichedAt'] == null
          ? null
          : DateTime.parse(json['enrichedAt'] as String),
      founder: json['founder'] as String?,
      founderExpanded: json['founderExpanded'] == null
          ? null
          : UserDto.fromJson(json['founderExpanded'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? null
          : TokenMetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      metadataCreatorsExpanded:
          json['metadataCreatorsExpanded'] as List<dynamic>?,
      owner: json['owner'] as String?,
      ownerExpanded: json['ownerExpanded'] == null
          ? null
          : UserDto.fromJson(json['ownerExpanded'] as Map<String, dynamic>),
      royalties: (json['royalties'] as List<dynamic>?)
          ?.map((e) => TokenRoyaltyDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      uri: json['uri'] as String?,
    );

Map<String, dynamic> _$$_TokenComplexDtoToJson(_$_TokenComplexDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'network': instance.network,
      'tokenId': instance.tokenId,
      'registry': instance.registry,
      'contract': instance.contract,
      'order': instance.order,
      'createdAt': instance.createdAt?.toIso8601String(),
      'creator': instance.creator,
      'creatorExpanded': instance.creatorExpanded,
      'enrichCount': instance.enrichCount,
      'enrichedAt': instance.enrichedAt?.toIso8601String(),
      'founder': instance.founder,
      'founderExpanded': instance.founderExpanded,
      'metadata': instance.metadata,
      'metadataCreatorsExpanded': instance.metadataCreatorsExpanded,
      'owner': instance.owner,
      'ownerExpanded': instance.ownerExpanded,
      'royalties': instance.royalties,
      'uri': instance.uri,
    };

_$_TokenDetailDto _$$_TokenDetailDtoFromJson(Map<String, dynamic> json) =>
    _$_TokenDetailDto(
      id: json['id'] as String?,
      network: json['network'] as String?,
      tokenId: json['tokenId'] as String?,
      metadata: json['metadata'] == null
          ? null
          : TokenMetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TokenDetailDtoToJson(_$_TokenDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'network': instance.network,
      'tokenId': instance.tokenId,
      'metadata': instance.metadata,
    };

_$_RegistryDto _$$_RegistryDtoFromJson(Map<String, dynamic> json) =>
    _$_RegistryDto(
      id: json['id'] as String?,
      network: json['network'] as String?,
      isERC721: json['isERC721'] as bool?,
      supportsERC721Metadata: json['supportsERC721Metadata'] as bool?,
      supportsERC2981: json['supportsERC2981'] as bool?,
      supportsLemonadePoapV1: json['supportsLemonadePoapV1'] as bool?,
      supportsRaribleRoyaltiesV2: json['supportsRaribleRoyaltiesV2'] as bool?,
    );

Map<String, dynamic> _$$_RegistryDtoToJson(_$_RegistryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'network': instance.network,
      'isERC721': instance.isERC721,
      'supportsERC721Metadata': instance.supportsERC721Metadata,
      'supportsERC2981': instance.supportsERC2981,
      'supportsLemonadePoapV1': instance.supportsLemonadePoapV1,
      'supportsRaribleRoyaltiesV2': instance.supportsRaribleRoyaltiesV2,
    };

_$_OrderSimpleDto _$$_OrderSimpleDtoFromJson(Map<String, dynamic> json) =>
    _$_OrderSimpleDto(
      id: json['id'] as String,
      contract: json['contract'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      kind: $enumDecode(_$OrderKindEnumMap, json['kind']),
      maker: json['maker'] as String,
      network: json['network'] as String,
      open: json['open'] as bool,
      orderId: json['orderId'] as String,
      price: json['price'] as String,
      token: json['token'] as String,
      bidAmount: json['bidAmount'] as String?,
      bidder: json['bidder'] as String?,
      currency: json['currency'] == null
          ? null
          : OrderCurrencyDto.fromJson(json['currency'] as Map<String, dynamic>),
      makerExpanded: json['makerExpanded'] == null
          ? null
          : UserDto.fromJson(json['makerExpanded'] as Map<String, dynamic>),
      openFrom: json['openFrom'] == null
          ? null
          : DateTime.parse(json['openFrom'] as String),
      openTo: json['openTo'] == null
          ? null
          : DateTime.parse(json['openTo'] as String),
      paidAmount: json['paidAmount'] as String?,
      taker: json['taker'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_OrderSimpleDtoToJson(_$_OrderSimpleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contract': instance.contract,
      'createdAt': instance.createdAt.toIso8601String(),
      'kind': _$OrderKindEnumMap[instance.kind]!,
      'maker': instance.maker,
      'network': instance.network,
      'open': instance.open,
      'orderId': instance.orderId,
      'price': instance.price,
      'token': instance.token,
      'bidAmount': instance.bidAmount,
      'bidder': instance.bidder,
      'currency': instance.currency,
      'makerExpanded': instance.makerExpanded,
      'openFrom': instance.openFrom?.toIso8601String(),
      'openTo': instance.openTo?.toIso8601String(),
      'paidAmount': instance.paidAmount,
      'taker': instance.taker,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$OrderKindEnumMap = {
  OrderKind.AUCTION: 'AUCTION',
  OrderKind.DIRECT: 'DIRECT',
};

_$_OrderCurrencyDto _$$_OrderCurrencyDtoFromJson(Map<String, dynamic> json) =>
    _$_OrderCurrencyDto(
      id: json['id'] as String,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$$_OrderCurrencyDtoToJson(_$_OrderCurrencyDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
    };

_$_TokenRoyaltyDto _$$_TokenRoyaltyDtoFromJson(Map<String, dynamic> json) =>
    _$_TokenRoyaltyDto(
      account: json['account'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$$_TokenRoyaltyDtoToJson(_$_TokenRoyaltyDto instance) =>
    <String, dynamic>{
      'account': instance.account,
      'value': instance.value,
    };

_$_TokenMetadataDto _$$_TokenMetadataDtoFromJson(Map<String, dynamic> json) =>
    _$_TokenMetadataDto(
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      animation_url: json['animation_url'] as String?,
      external_url: json['external_url'] as String?,
      creators: (json['creators'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$$_TokenMetadataDtoToJson(_$_TokenMetadataDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'animation_url': instance.animation_url,
      'external_url': instance.external_url,
      'creators': instance.creators,
    };

_$_TokenSimpleDto _$$_TokenSimpleDtoFromJson(Map<String, dynamic> json) =>
    _$_TokenSimpleDto(
      id: json['id'] as String,
      network: json['network'] as String,
      tokenId: json['tokenId'] as String,
      typename: json['typename'] as String?,
      contract: json['contract'] as String?,
      createdAt: json['createdAt'] as String?,
      creator: json['creator'] as String?,
      creatorExpanded: json['creatorExpanded'] == null
          ? null
          : UserDto.fromJson(json['creatorExpanded'] as Map<String, dynamic>),
      enrichCount: (json['enrichCount'] as num?)?.toDouble(),
      enrichedAt: json['enrichedAt'] as String?,
      founder: json['founder'] as String?,
      founderExpanded: json['founderExpanded'] == null
          ? null
          : UserDto.fromJson(json['founderExpanded'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? null
          : TokenMetadataDto.fromJson(json['metadata'] as Map<String, dynamic>),
      metadataCreatorsExpanded:
          (json['metadataCreatorsExpanded'] as List<dynamic>?)
              ?.map((e) => UserDto.fromJson(e as Map<String, dynamic>))
              .toList(),
      order: json['order'] as String?,
      royalties: (json['royalties'] as List<dynamic>?)
          ?.map((e) => TokenRoyaltyDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      royaltyFraction: json['royaltyFraction'] as String?,
      royaltyMaker: json['royaltyMaker'] as String?,
      uri: json['uri'] as String?,
    );

Map<String, dynamic> _$$_TokenSimpleDtoToJson(_$_TokenSimpleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'network': instance.network,
      'tokenId': instance.tokenId,
      'typename': instance.typename,
      'contract': instance.contract,
      'createdAt': instance.createdAt,
      'creator': instance.creator,
      'creatorExpanded': instance.creatorExpanded,
      'enrichCount': instance.enrichCount,
      'enrichedAt': instance.enrichedAt,
      'founder': instance.founder,
      'founderExpanded': instance.founderExpanded,
      'metadata': instance.metadata,
      'metadataCreatorsExpanded': instance.metadataCreatorsExpanded,
      'order': instance.order,
      'royalties': instance.royalties,
      'royaltyFraction': instance.royaltyFraction,
      'royaltyMaker': instance.royaltyMaker,
      'uri': instance.uri,
    };
