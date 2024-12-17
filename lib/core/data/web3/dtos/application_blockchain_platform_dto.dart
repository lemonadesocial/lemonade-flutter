import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_blockchain_platform_dto.freezed.dart';
part 'application_blockchain_platform_dto.g.dart';

@freezed
class ApplicationBlockchainPlatformDto with _$ApplicationBlockchainPlatformDto {
  factory ApplicationBlockchainPlatformDto({
    Enum$BlockchainPlatform? platform,
    @JsonKey(name: 'required') bool? isRequired,
  }) = _ApplicationBlockchainPlatformDto;

  factory ApplicationBlockchainPlatformDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ApplicationBlockchainPlatformDtoFromJson(json);
}
