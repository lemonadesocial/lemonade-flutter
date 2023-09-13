import 'package:app/core/data/token/dtos/token_dtos.dart';
import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/token/token_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';

class TokenComplex {
  const TokenComplex({
    required this.id,
    required this.network,
    required this.tokenId,
    required this.registry,
    required this.contract,
    this.order,
    this.createdAt,
    this.creator,
    this.creatorExpanded,
    this.enrichCount,
    this.enrichedAt,
    this.founder,
    this.founderExpanded,
    this.metadata,
    this.metadataCreatorsExpanded,
    this.owner,
    this.ownerExpanded,
    this.royalties,
    this.uri,
  });

  factory TokenComplex.fromDto(TokenComplexDto dto) => TokenComplex(
        id: dto.id,
        network: dto.network,
        tokenId: dto.tokenId,
        registry: dto.registry,
        contract: dto.contract,
        order: dto.order,
        createdAt: dto.createdAt,
        creator: dto.creator,
        creatorExpanded: dto.creatorExpanded != null
            ? User.fromDto(dto.creatorExpanded!)
            : null,
        enrichCount: dto.enrichCount,
        enrichedAt: dto.enrichedAt,
        founder: dto.founder,
        founderExpanded: dto.founderExpanded != null
            ? User.fromDto(dto.founderExpanded!)
            : null,
        metadata:
            dto.metadata != null ? TokenMetadata.fromDto(dto.metadata!) : null,
        metadataCreatorsExpanded: dto.metadataCreatorsExpanded,
        owner: dto.owner,
        ownerExpanded:
            dto.ownerExpanded != null ? User.fromDto(dto.ownerExpanded!) : null,
        royalties: List<TokenRoyaltyDto>.from(dto.royalties ?? [])
            .map(TokenRoyalty.fromDto)
            .toList(),
        uri: dto.uri,
      );
  final String id;
  final String network;
  final String tokenId;
  final RegistryDto registry;
  final String contract;
  final OrderSimpleDto? order;
  final DateTime? createdAt;
  final String? creator;
  final User? creatorExpanded;
  final double? enrichCount;
  final DateTime? enrichedAt;
  final String? founder;
  final User? founderExpanded;
  final TokenMetadata? metadata;
  final List? metadataCreatorsExpanded;
  final String? owner;
  final User? ownerExpanded;
  final List<TokenRoyalty>? royalties;
  final String? uri;
}

class TokenDetail {
  TokenDetail({
    this.id,
    this.contract,
    this.network,
    this.tokenId,
    this.metadata,
  });

  factory TokenDetail.fromDto(TokenDetailDto dto) => TokenDetail(
        id: dto.id,
        tokenId: dto.tokenId,
        contract: dto.contract,
        network: dto.network,
        metadata:
            dto.metadata != null ? TokenMetadata.fromDto(dto.metadata!) : null,
      );

  final String? id;
  final String? contract;
  final String? network;
  final String? tokenId;
  final TokenMetadata? metadata;
}

class Registry {
  const Registry({
    this.id,
    this.network,
    this.isERC721,
    this.supportsERC721Metadata,
    this.supportsERC2981,
    this.supportsLemonadePoapV1,
    this.supportsRaribleRoyaltiesV2,
  });

  factory Registry.fromDto(RegistryDto dto) => Registry(
        id: dto.id,
        network: dto.network,
        isERC721: dto.isERC721,
        supportsERC721Metadata: dto.supportsERC721Metadata,
        supportsERC2981: dto.supportsERC2981,
        supportsLemonadePoapV1: dto.supportsLemonadePoapV1,
        supportsRaribleRoyaltiesV2: dto.supportsRaribleRoyaltiesV2,
      );
  final String? id;
  final String? network;
  final bool? isERC721;
  final bool? supportsERC721Metadata;
  final bool? supportsERC2981;
  final bool? supportsLemonadePoapV1;
  final bool? supportsRaribleRoyaltiesV2;
}

class OrderSimple {
  const OrderSimple({
    required this.id,
    required this.contract,
    required this.createdAt,
    required this.kind,
    required this.maker,
    required this.network,
    required this.open,
    required this.orderId,
    required this.price,
    required this.token,
    required this.bidAmount,
    this.bidder,
    this.currency,
    this.makerExpanded,
    this.openFrom,
    this.openTo,
    this.paidAmount,
    this.taker,
    this.updatedAt,
  });

  factory OrderSimple.fromDto(OrderSimpleDto dto) => OrderSimple(
        id: dto.id,
        contract: dto.contract,
        createdAt: dto.createdAt,
        kind: dto.kind,
        maker: dto.maker,
        network: dto.network,
        open: dto.open,
        orderId: dto.orderId,
        price: dto.price,
        token: dto.token,
        bidAmount: dto.bidAmount,
        bidder: dto.bidder,
        currency:
            dto.currency != null ? OrderCurrency.fromDto(dto.currency!) : null,
        makerExpanded:
            dto.makerExpanded != null ? User.fromDto(dto.makerExpanded!) : null,
        openFrom: dto.openFrom,
        openTo: dto.openTo,
        paidAmount: dto.paidAmount,
        taker: dto.taker,
        updatedAt: dto.updatedAt,
      );
  final String id;
  final String contract;
  final DateTime createdAt;
  final OrderKind kind;
  final String maker;
  final String network;
  final bool open;
  final String orderId;
  final String price;
  final String token;
  final String? bidAmount;
  final String? bidder;
  final OrderCurrency? currency;
  final User? makerExpanded;
  final DateTime? openFrom;
  final DateTime? openTo;
  final String? paidAmount;
  final String? taker;
  final DateTime? updatedAt;
}

class OrderCurrency {
  const OrderCurrency({
    required this.id,
    this.name,
    this.symbol,
  });

  factory OrderCurrency.fromDto(OrderCurrencyDto dto) => OrderCurrency(
        id: dto.id,
        name: dto.name,
        symbol: dto.symbol,
      );
  final String id;
  final String? name;
  final String? symbol;
}

class TokenRoyalty {
  const TokenRoyalty({
    required this.account,
    required this.value,
  });

  factory TokenRoyalty.fromDto(TokenRoyaltyDto dto) => TokenRoyalty(
        account: dto.account,
        value: dto.value,
      );
  final String account;
  final String value;
}

class TokenMetadata {
  const TokenMetadata({
    this.name,
    this.description,
    this.image,
    this.animation_url,
    this.external_url,
    this.creators,
    // attributes?: Attribute[];
  });

  factory TokenMetadata.fromDto(TokenMetadataDto dto) => TokenMetadata(
        name: dto.name,
        description: dto.description,
        image: dto.image,
        animation_url: dto.animation_url,
        external_url: dto.external_url,
        creators: dto.creators,
      );
  final String? name;
  final String? description;
  final String? image;
  final String? animation_url;
  final String? external_url;
  final List<String?>? creators;
}

class TokenSimple {
  const TokenSimple({
    required this.id,
    required this.network,
    required this.tokenId,
    this.typename,
    this.contract,
    this.createdAt,
    this.creator,
    this.creatorExpanded,
    this.enrichCount,
    this.enrichedAt,
    this.founder,
    this.founderExpanded,
    this.metadata,
    this.metadataCreatorsExpanded,
    this.order,
    this.royalties,
    this.uri,
  });

  factory TokenSimple.fromDto(TokenSimpleDto dto) => TokenSimple(
        id: dto.id,
        network: dto.network,
        tokenId: dto.tokenId,
        typename: dto.typename,
        contract: dto.contract,
        createdAt: dto.createdAt,
        creator: dto.creator,
        creatorExpanded: dto.creatorExpanded != null
            ? User.fromDto(dto.creatorExpanded!)
            : null,
        enrichCount: dto.enrichCount,
        enrichedAt: dto.enrichedAt,
        founder: dto.founder,
        founderExpanded: dto.founderExpanded != null
            ? User.fromDto(dto.founderExpanded!)
            : null,
        metadata:
            dto.metadata != null ? TokenMetadata.fromDto(dto.metadata!) : null,
        metadataCreatorsExpanded:
            List<UserDto>.from(dto.metadataCreatorsExpanded ?? [])
                .map(User.fromDto)
                .toList(),
        order: dto.order,
        royalties: List<TokenRoyaltyDto>.from(dto.royalties ?? [])
            .map(TokenRoyalty.fromDto)
            .toList(),
        uri: dto.uri,
      );
  final String id;
  final String network;
  final String tokenId;
  final String? typename;
  final String? contract;
  final String? createdAt;
  final String? creator;
  final User? creatorExpanded;
  final double? enrichCount;
  final String? enrichedAt;
  final String? founder;
  final User? founderExpanded;
  final TokenMetadata? metadata;
  final List<User>? metadataCreatorsExpanded;
  final String? order;
  final List<TokenRoyalty>? royalties;
  final String? uri;
}
