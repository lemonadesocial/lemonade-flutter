import 'package:app/core/domain/token-gating/entities/space_token_gate.dart';
import 'package:app/core/domain/token-gating/entities/sync_space_token_gate_access_response.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class TokenGatingRepository {
  Future<Either<Failure, List<SpaceTokenGate>>> listSpaceTokenGates({
    required String spaceId,
    bool refresh = false,
  });

  Future<Either<Failure, SyncSpaceTokenGateAccessResponse>>
      syncSpaceTokenGateAccess({
    required String spaceId,
  });
}
