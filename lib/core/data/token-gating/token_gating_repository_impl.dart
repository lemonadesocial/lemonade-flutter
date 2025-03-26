import 'package:app/core/data/token-gating/dtos/space_token_gate_dto.dart';
import 'package:app/core/data/token-gating/dtos/sync_space_token_gate_access_response_dto.dart';
import 'package:app/core/domain/token-gating/token_gating_repository.dart';
import 'package:app/core/domain/token-gating/entities/space_token_gate.dart';
import 'package:app/core/domain/token-gating/entities/sync_space_token_gate_access_response.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/token-gating/mutation/sync_space_token_gate_access.graphql.dart';
import 'package:app/graphql/backend/token-gating/query/list_space_token_gates.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenGatingRepository)
class TokenGatingRepositoryImpl implements TokenGatingRepository {
  final _client = getIt<AppGQL>().client;

  TokenGatingRepositoryImpl();

  @override
  Future<Either<Failure, List<SpaceTokenGate>>> listSpaceTokenGates({
    required String spaceId,
    bool refresh = false,
  }) async {
    final result = await _client.query$ListSpaceTokenGates(
      Options$Query$ListSpaceTokenGates(
        fetchPolicy: refresh ? FetchPolicy.networkOnly : FetchPolicy.cacheFirst,
        variables: Variables$Query$ListSpaceTokenGates(
          space: spaceId,
        ),
      ),
    );

    if (result.hasException || result.parsedData?.listSpaceTokenGates == null) {
      return Left(Failure.withGqlException(result.exception));
    }

    return Right(
      result.parsedData!.listSpaceTokenGates
          .map(
            (e) => SpaceTokenGate.fromDto(
              SpaceTokenGateDto.fromJson(e.toJson()),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<Either<Failure, SyncSpaceTokenGateAccessResponse>>
      syncSpaceTokenGateAccess({
    required String spaceId,
  }) async {
    final result = await _client.mutate$SyncSpaceTokenGateAccess(
      Options$Mutation$SyncSpaceTokenGateAccess(
        variables: Variables$Mutation$SyncSpaceTokenGateAccess(
          space: spaceId,
        ),
      ),
    );

    if (result.hasException ||
        result.parsedData?.syncSpaceTokenGateAccess == null) {
      return Left(Failure.withGqlException(result.exception));
    }

    return Right(
      SyncSpaceTokenGateAccessResponse.fromDto(
        SyncSpaceTokenGateAccessResponseDto.fromJson(
          result.parsedData!.syncSpaceTokenGateAccess.toJson(),
        ),
      ),
    );
  }
}
