import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/core/domain/token/token_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_dtos.freezed.dart';
part 'token_dtos.g.dart';

@freezed
class TokenComplexDto with _$TokenComplexDto {
  const factory TokenComplexDto({
    required String id,
    required String network,
    required String tokenId,
    required RegistryDto registry,
    required String contract,
    OrderSimpleDto? order,
    DateTime? createdAt,
    String? creator,
    UserDto? creatorExpanded,
    double? enrichCount,
    DateTime? enrichedAt,
    String? founder,
    UserDto? founderExpanded,
    TokenMetadataDto? metadata,
    List? metadataCreatorsExpanded,
    String? owner,
    UserDto? ownerExpanded,
    List<TokenRoyaltyDto>? royalties,
    String? uri,
  }) = _TokenComplexDto;

  factory TokenComplexDto.fromJson(Map<String, dynamic> json) =>
      _$TokenComplexDtoFromJson(json);
}

@freezed
class TokenDetailDto with _$TokenDetailDto {
  const factory TokenDetailDto({
    String? id,
    String? tokenId,
    String? contract,
    String? network,
    TokenMetadataDto? metadata,
  }) = _TokenDetailDto;

  factory TokenDetailDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailDtoFromJson(json);
}

@freezed
class RegistryDto with _$RegistryDto {
  const factory RegistryDto({
    String? id,
    String? network,
    bool? isERC721,
    bool? supportsERC721Metadata,
    bool? supportsERC2981,
    bool? supportsLemonadePoapV1,
    bool? supportsRaribleRoyaltiesV2,
  }) = _RegistryDto;

  factory RegistryDto.fromJson(Map<String, dynamic> json) =>
      _$RegistryDtoFromJson(json);
}

@freezed
class OrderSimpleDto with _$OrderSimpleDto {
  const factory OrderSimpleDto({
    required String id,
    required String contract,
    required DateTime createdAt,
    required OrderKind kind,
    required String maker,
    required String network,
    required bool open,
    required String orderId,
    required String price,
    required String token,
    String? bidAmount,
    String? bidder,
    OrderCurrencyDto? currency,
    UserDto? makerExpanded,
    DateTime? openFrom,
    DateTime? openTo,
    String? paidAmount,
    String? taker,
    DateTime? updatedAt,
  }) = _OrderSimpleDto;

  factory OrderSimpleDto.fromJson(Map<String, dynamic> json) =>
      _$OrderSimpleDtoFromJson(json);
}

@freezed
class OrderCurrencyDto with _$OrderCurrencyDto {
  const factory OrderCurrencyDto({
    required String id,
    String? name,
    String? symbol,
  }) = _OrderCurrencyDto;

  factory OrderCurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$OrderCurrencyDtoFromJson(json);
}

@freezed
class TokenRoyaltyDto with _$TokenRoyaltyDto {
  const factory TokenRoyaltyDto({
    required String account,
    required String value,
  }) = _TokenRoyaltyDto;

  factory TokenRoyaltyDto.fromJson(Map<String, dynamic> json) =>
      _$TokenRoyaltyDtoFromJson(json);
}

@freezed
class TokenMetadataDto with _$TokenMetadataDto {
  const factory TokenMetadataDto({
    String? name,
    String? description,
    String? image,
    String? animation_url,
    String? external_url,
    List<String?>? creators,
    // attributes?: Attribute[];
  }) = _TokenMetadataDto;

  factory TokenMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$TokenMetadataDtoFromJson(json);
}

@freezed
class TokenSimpleDto with _$TokenSimpleDto {
  const factory TokenSimpleDto({
    required String id,
    required String network,
    required String tokenId,
    String? typename,
    String? contract,
    String? createdAt,
    String? creator,
    UserDto? creatorExpanded,
    double? enrichCount,
    String? enrichedAt,
    String? founder,
    UserDto? founderExpanded,
    TokenMetadataDto? metadata,
    List<UserDto>? metadataCreatorsExpanded,
    String? order,
    List<TokenRoyaltyDto>? royalties,
    String? royaltyFraction,
    String? royaltyMaker,
    String? uri,
  }) = _TokenSimpleDto;

  factory TokenSimpleDto.fromJson(Map<String, dynamic> json) =>
      _$TokenSimpleDtoFromJson(json);
}
