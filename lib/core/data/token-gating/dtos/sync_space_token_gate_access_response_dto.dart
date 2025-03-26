import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_space_token_gate_access_response_dto.freezed.dart';
part 'sync_space_token_gate_access_response_dto.g.dart';

@freezed
class SyncSpaceTokenGateAccessResponseDto
    with _$SyncSpaceTokenGateAccessResponseDto {
  const factory SyncSpaceTokenGateAccessResponseDto({
    required List<Enum$SpaceRole> roles,
  }) = _SyncSpaceTokenGateAccessResponseDto;

  factory SyncSpaceTokenGateAccessResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SyncSpaceTokenGateAccessResponseDtoFromJson(json);
}
