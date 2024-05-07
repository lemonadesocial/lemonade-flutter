import 'package:app/core/domain/collaborator/entities/user_discovery/user_discovery.dart';
import 'package:app/core/domain/collaborator/entities/user_discovery_swipe/user_discovery_swipe.dart';
import 'package:app/core/domain/collaborator/entities/user_expertise/user_expertise.dart';
import 'package:app/core/domain/user/entities/user_service_offer.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/collaborator/mutation/accept_user_discovery.graphql.dart';
import 'package:app/graphql/backend/collaborator/mutation/decline_user_discovery.graphql.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery.graphql.dart';
import 'package:app/graphql/backend/collaborator/query/get_user_discovery_swipes.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:dartz/dartz.dart';

abstract class CollaboratorRepository {
  Future<Either<Failure, UserDiscovery>> getUserDiscovery({
    required Variables$Query$GetUserDiscovery input,
  });

  Future<Either<Failure, Enum$UserDiscoverySwipeState>> acceptUserDiscovery({
    required Variables$Mutation$AcceptUserDiscovery input,
  });

  Future<Either<Failure, bool>> declineUserDiscovery({
    required Variables$Mutation$DeclineUserDiscovery input,
  });

  Future<Either<Failure, List<UserDiscoverySwipe>>> getUserDiscoverySwipes({
    required Variables$Query$GetUserDiscoverySwipes input,
  });

  Future<Either<Failure, List<UserExpertise>>> getListUserExpertises();

  Future<Either<Failure, List<UserServiceOffer>>> getListUserServices();
}
