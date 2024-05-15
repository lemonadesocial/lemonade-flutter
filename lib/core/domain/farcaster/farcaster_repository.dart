import 'package:app/core/domain/farcaster/entities/farcaster_account_key_request.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_signed_key_request.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_cast.graphql.dart';
import 'package:dartz/dartz.dart';

abstract class FarcasterRepository {
  Future<Either<Failure, FarcasterAccountKeyRequest>>
      createFarcasterAccountKey();

  Future<Either<Failure, FarcasterSignedKeyRequest>> getConnectRequest(
    String token,
  );

  Future<Either<Failure, bool>> createCast({
    required Variables$Mutation$CreateCast input,
  });
}
