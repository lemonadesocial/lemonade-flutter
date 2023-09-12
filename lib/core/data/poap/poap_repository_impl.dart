import 'package:app/core/data/poap/dtos/poap_dtos.dart';
import 'package:app/core/data/poap/poap_subscription.dart';
import 'package:app/core/data/poap/poap_mutation.dart';
import 'package:app/core/data/poap/poap_query.dart';
import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PoapRepository)
class PoapRepositoryImpl implements PoapRepository {
  final _walletClient = getIt<WalletGQL>().client;
  @override
  Future<Either<Failure, PoapViewSupply>> getPoapViewSupply({
    required GetPoapViewSupplyInput input,
  }) async {
    final result = await _walletClient.query(
      QueryOptions(
        document: getPoapViewQuery,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: input.toJson(),
        parserFn: (data) => PoapViewSupply.fromDto(
          PoapViewSupplyDto.fromJson(data['poapView']),
        ),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, PoapViewCheckHasClaimed>> checkHasClaimedPoap({
    required CheckHasClaimedPoapViewInput input,
    bool fromServer = false,
  }) async {
    final result = await _walletClient.query(
      QueryOptions(
        document: checkHasClaimedPoapQuery,
        fetchPolicy: fromServer ? FetchPolicy.networkOnly : null,
        variables: input.toJson(),
        parserFn: (data) => PoapViewCheckHasClaimed.fromDto(
          PoapViewCheckHasClaimedDto.fromJson(data['poapView']),
        ),
      ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, Claim>> claim({
    required ClaimInput input,
  }) async {
    final result = await _walletClient.mutate(
      MutationOptions(
        document: claimPoapMutation,
        fetchPolicy: FetchPolicy.networkOnly,
        variables: input.toJson(),
        parserFn: (data) => Claim.fromDto(ClaimDto.fromJson(data['claimPoap'])),
      ),
    );
    if (result.hasException) {
      return Left(
        Failure.withGqlException(result.exception),
      );
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, PoapPolicy>> getPoapPolicy({
    required GetPoapPolicyInput input,
  }) async {
    final result = await _walletClient.query(
      QueryOptions(
        document: getPoapPolicyQuery,
        variables: input.toJson(),
        parserFn: (data) => PoapPolicy.fromDto(
          PoapPolicyDto.fromJson(data['getPolicy']),
        ),
      ),
    );
    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData!);
  }

  @override
  Stream<Either<Failure, Claim?>> watchClaimModification() {
    final stream = _walletClient.subscribe(
      SubscriptionOptions(
          document: claimModifiedSubscription,
          fetchPolicy: FetchPolicy.networkOnly,
          parserFn: (data) {
            final rawClaimModification = data['claimModified'];
            if (rawClaimModification == null) return null;
            return Claim.fromDto(ClaimDto.fromJson(rawClaimModification));
          }),
    );

    return stream.asyncMap((resultEvent) {
      if (resultEvent.hasException) return Left(Failure());
      return Right(resultEvent.parsedData);
    });
  }
}
