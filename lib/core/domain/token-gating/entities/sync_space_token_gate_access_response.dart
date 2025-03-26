import 'package:app/core/data/token-gating/dtos/sync_space_token_gate_access_response_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_space_token_gate_access_response.freezed.dart';
part 'sync_space_token_gate_access_response.g.dart';

@freezed
class SyncSpaceTokenGateAccessResponse with _$SyncSpaceTokenGateAccessResponse {
  const SyncSpaceTokenGateAccessResponse._();

  const factory SyncSpaceTokenGateAccessResponse({
    required List<Enum$SpaceRole> roles,
  }) = _SyncSpaceTokenGateAccessResponse;

  factory SyncSpaceTokenGateAccessResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SyncSpaceTokenGateAccessResponseFromJson(json);

  factory SyncSpaceTokenGateAccessResponse.fromDto(
    SyncSpaceTokenGateAccessResponseDto dto,
  ) {
    return SyncSpaceTokenGateAccessResponse(
      roles: dto.roles,
    );
  }
}
