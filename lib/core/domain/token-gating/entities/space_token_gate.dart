import 'package:app/core/data/token-gating/dtos/space_token_gate_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_token_gate.freezed.dart';
part 'space_token_gate.g.dart';

@freezed
class SpaceTokenGate with _$SpaceTokenGate {
  const SpaceTokenGate._();

  const factory SpaceTokenGate({
    String? id,
    String? name,
    String? tokenAddress,
    double? decimals,
    String? minValue,
    String? maxValue,
    String? network,
    bool? isNft,
    String? space,
    List<Enum$SpaceRole>? roles,
    bool? passed,
  }) = _SpaceTokenGate;

  factory SpaceTokenGate.fromJson(Map<String, dynamic> json) =>
      _$SpaceTokenGateFromJson(json);

  factory SpaceTokenGate.fromDto(SpaceTokenGateDto dto) {
    return SpaceTokenGate(
      id: dto.id,
      name: dto.name,
      tokenAddress: dto.tokenAddress,
      decimals: dto.decimals,
      minValue: dto.minValue,
      maxValue: dto.maxValue,
      network: dto.network,
      isNft: dto.isNft,
      space: dto.space,
      roles: dto.roles,
      passed: dto.passed,
    );
  }
}
