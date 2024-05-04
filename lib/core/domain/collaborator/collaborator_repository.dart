import 'package:app/core/domain/collaborator/entities/user_discovery/user_discovery.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery.graphql.dart';
import 'package:dartz/dartz.dart';

abstract class CollaboratorRepository {
  Future<Either<Failure, UserDiscovery>> getUserDiscovery({
    required Variables$Query$GetUserDiscovery input,
  });
}
