import 'package:app/core/domain/reward/entities/reward_signature_response.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RewardRepository {
  Future<Either<Failure, List<TokenRewardSetting>>>
      listCheckinTokenRewardSettings({
    required String event,
    List<String>? ticketTypes,
  });

  Future<Either<Failure, List<TokenRewardSetting>>>
      listTicketTokenRewardSettings({
    required String event,
    List<String>? ticketTypes,
  });

  Future<Either<Failure, RewardSignatureResponse>>
      generateClaimCheckinRewardSignature({
    required String event,
  });

  Future<Either<Failure, RewardSignatureResponse>>
      generateClaimTicketRewardSignature({
    required String event,
    String? payment,
  });
}
