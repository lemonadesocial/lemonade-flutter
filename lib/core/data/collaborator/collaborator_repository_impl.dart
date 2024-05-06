import 'package:app/core/data/collaborator/dtos/user_discovery_dto/user_discovery_dto.dart';
import 'package:app/core/domain/collaborator/collaborator_repository.dart';
import 'package:app/core/domain/collaborator/entities/user_discovery/user_discovery.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/collaborator/mutation/accept_user_discovery.graphql.dart';
import 'package:app/graphql/backend/collaborator/mutation/decline_user_discovery.graphql.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CollaboratorRepository)
class CollaboratorRepositoryImpl implements CollaboratorRepository {
  final _client = getIt<AppGQL>().client;
  @override
  Future<Either<Failure, UserDiscovery>> getUserDiscovery({
    required Variables$Query$GetUserDiscovery input,
  }) async {
    final result = await _client.query$GetUserDiscovery(
      Options$Query$GetUserDiscovery(
        variables: input,
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    if (result.hasException || result.parsedData?.getUserDiscovery == null) {
      return Left(Failure());
    }
    return Right(
      UserDiscovery.fromDto(
        UserDiscoveryDto.fromJson(
          result.parsedData!.getUserDiscovery.toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, Enum$UserDiscoverySwipeState>> acceptUserDiscovery({
    required Variables$Mutation$AcceptUserDiscovery input,
  }) async {
    final result = await _client.mutate$AcceptUserDiscovery(
      Options$Mutation$AcceptUserDiscovery(
        variables: input,
      ),
    );
    if (result.hasException ||
        result.parsedData?.acceptUserDiscovery.state == null) {
      return Left(Failure());
    }
    return Right(result.parsedData!.acceptUserDiscovery.state!);
  }

  @override
  Future<Either<Failure, bool>> declineUserDiscovery({
    required Variables$Mutation$DeclineUserDiscovery input,
  }) async {
    final result = await _client.mutate$DeclineUserDiscovery(
      Options$Mutation$DeclineUserDiscovery(variables: input),
    );
    if (result.hasException ||
        result.parsedData?.declineUserDiscovery == null) {
      return Left(Failure());
    }
    return Right(result.parsedData?.declineUserDiscovery ?? false);
  }
}
