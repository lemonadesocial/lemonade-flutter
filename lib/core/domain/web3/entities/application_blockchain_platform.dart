import 'package:app/core/data/web3/dtos/application_blockchain_platform_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_blockchain_platform.freezed.dart';
part 'application_blockchain_platform.g.dart';

@freezed
class ApplicationBlockchainPlatform with _$ApplicationBlockchainPlatform {
  factory ApplicationBlockchainPlatform({
    Enum$BlockchainPlatform? platform,
    bool? isRequired,
  }) = _ApplicationBlockchainPlatform;

  factory ApplicationBlockchainPlatform.fromDto(
    ApplicationBlockchainPlatformDto dto,
  ) {
    return ApplicationBlockchainPlatform(
      platform: dto.platform,
      isRequired: dto.isRequired,
    );
  }

  factory ApplicationBlockchainPlatform.fromJson(Map<String, dynamic> json) =>
      _$ApplicationBlockchainPlatformFromJson(json);
}
