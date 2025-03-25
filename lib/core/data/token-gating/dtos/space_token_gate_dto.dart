import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_token_gate_dto.freezed.dart';
part 'space_token_gate_dto.g.dart';

@freezed
class SpaceTokenGateDto with _$SpaceTokenGateDto {
  const factory SpaceTokenGateDto({
    @JsonKey(name: '_id') String? id,
    String? name,
    @JsonKey(name: 'token_address') String? tokenAddress,
    double? decimals,
    @JsonKey(name: 'min_value') String? minValue,
    @JsonKey(name: 'max_value') String? maxValue,
    String? network,
    @JsonKey(name: 'is_nft') bool? isNft,
    String? space,
    List<Enum$SpaceRole>? roles,
    bool? passed,
  }) = _SpaceTokenGateDto;

  factory SpaceTokenGateDto.fromJson(Map<String, dynamic> json) =>
      _$SpaceTokenGateDtoFromJson(json);
}
