import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_tokens_input.freezed.dart';
part 'get_tokens_input.g.dart';

@freezed
class GetTokensInput with _$GetTokensInput {
  const factory GetTokensInput({
    @JsonKey(includeIfNull: false) String? owner,
    @JsonKey(name: 'owner_in', includeIfNull: false) List<String>? ownerIn,
    @JsonKey(includeIfNull: false) String? tokenId,
    @JsonKey(includeIfNull: false) String? contract,
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(includeIfNull: false, name: 'id_in') List<String>? idIn,
    @JsonKey(includeIfNull: false) String? creator,
    @JsonKey(includeIfNull: false) String? network,
    @Default(0) int skip,
    @JsonKey(includeIfNull: false) int? limit,
  }) = _GetTokensInput;

  factory GetTokensInput.fromJson(Map<String, dynamic> json) =>
      _$GetTokensInputFromJson(json);
}

@freezed
class GetTokenDetailInput with _$GetTokenDetailInput {
  @JsonSerializable(
    includeIfNull: false,
  )
  const factory GetTokenDetailInput({
    required String id,
    String? network,
  }) = _GetTokenDetailInput;

  factory GetTokenDetailInput.fromJson(Map<String, dynamic> json) =>
      _$GetTokenDetailInputFromJson(json);
}

@freezed
class GetTokenComplexInput with _$GetTokenComplexInput {
  @JsonSerializable(
    includeIfNull: false,
  )
  factory GetTokenComplexInput({
    TokenWhereComplex? where,
  }) = _GetTokenComplexInput;

  factory GetTokenComplexInput.fromJson(Map<String, dynamic> json) =>
      _$GetTokenComplexInputFromJson(json);
}

@freezed
class TokenWhereComplex with _$TokenWhereComplex {
  @JsonSerializable(
    includeIfNull: false,
  )
  factory TokenWhereComplex({
    @JsonKey(name: 'network_in') List<String>? networkIn,
    @JsonKey(name: 'contract_in') List<String>? contractIn,
    @JsonKey(name: 'tokenId_eq') String? tokenIdEq,
  }) = _TokenWhereComplex;

  factory TokenWhereComplex.fromJson(Map<String, dynamic> json) =>
      _$TokenWhereComplexFromJson(json);
}
