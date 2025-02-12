import 'package:app/core/data/reward/dtos/reward_signature_response_dto/reward_signature_response_dto.dart';
import 'package:app/core/data/reward/dtos/token_reward_setting_dto/token_reward_setting_dto.dart';
import 'package:app/core/domain/reward/entities/reward_signature_response.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/reward_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/reward/query/generate_claim_checkin_reward_signature.graphql.dart';
import 'package:app/graphql/backend/reward/query/generate_claim_ticket_reward_signature.graphql.dart';
import 'package:app/graphql/backend/reward/query/list_checkin_token_reward_settings.graphql.dart';
import 'package:app/graphql/backend/reward/query/list_ticket_token_reward_settings.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RewardRepository)
class RewardRepositoryImpl implements RewardRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<TokenRewardSetting>>>
      listCheckinTokenRewardSettings({
    required String event,
    List<String>? ticketTypes,
  }) async {
    final result = await _client.query$ListCheckinTokenRewardSettings(
      Options$Query$ListCheckinTokenRewardSettings(
        variables: Variables$Query$ListCheckinTokenRewardSettings(
          event: event,
          ticketTypes: ticketTypes,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }

    return Right(
      result.parsedData!.listCheckinTokenRewardSettings
          .map(
            (dto) => TokenRewardSetting.fromDto(
              TokenRewardSettingDto.fromJson(dto.toJson()),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, List<TokenRewardSetting>>>
      listTicketTokenRewardSettings({
    required String event,
    List<String>? ticketTypes,
  }) async {
    final result = await _client.query$ListTicketTokenRewardSettings(
      Options$Query$ListTicketTokenRewardSettings(
        variables: Variables$Query$ListTicketTokenRewardSettings(
          event: event,
          ticketTypes: ticketTypes,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException ||
        result.parsedData?.listTicketTokenRewardSettings == null) {
      return Left(Failure());
    }

    return Right(
      result.parsedData!.listTicketTokenRewardSettings
          .map(
            (dto) => TokenRewardSetting.fromDto(
              TokenRewardSettingDto.fromJson(dto.toJson()),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, RewardSignatureResponse>>
      generateClaimCheckinRewardSignature({
    required String event,
  }) async {
    final result = await _client.query$GenerateClaimCheckinRewardSignature(
      Options$Query$GenerateClaimCheckinRewardSignature(
        variables: Variables$Query$GenerateClaimCheckinRewardSignature(
          event: event,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException || result.parsedData == null) {
      return Left(Failure());
    }

    return Right(
      RewardSignatureResponse.fromDto(
        RewardSignatureResponseDto.fromJson(
          result.parsedData!.generateClaimCheckinRewardSignature!.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, RewardSignatureResponse>>
      generateClaimTicketRewardSignature({
    required String event,
    String? payment,
  }) async {
    final result = await _client.query$GenerateClaimTicketRewardSignature(
      Options$Query$GenerateClaimTicketRewardSignature(
        variables: Variables$Query$GenerateClaimTicketRewardSignature(
          event: event,
          payment: payment,
        ),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException ||
        result.parsedData?.generateClaimTicketRewardSignature == null) {
      return Left(Failure());
    }

    return Right(
      RewardSignatureResponse.fromDto(
        RewardSignatureResponseDto.fromJson(
          result.parsedData!.generateClaimTicketRewardSignature!.toJson(),
        ),
      ),
    );
  }
}
