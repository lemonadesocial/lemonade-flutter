import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_account_key_request.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_signed_key_request.dart';
import 'package:app/core/domain/farcaster/input/cast_has_reaction_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_cast.graphql.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_cast_reaction.graphql.dart';
import 'package:app/graphql/backend/farcaster/mutation/delete_cast_reaction.graphql.dart';
import 'package:app/graphql/farcaster_airstack/query/get_farcaster_users.graphql.dart';
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

  Future<Either<Failure, List<FarcasterChannel>>> getChannels({
    required int fid,
  });

  Future<Either<Failure, List<Map<String, dynamic>>>> getUsers({
    required Variables$Query$GetFarcasterUsers input,
  });

  Future<Either<Failure, bool>> createCastReaction({
    required Variables$Mutation$CreateCastReaction input,
  });

  Future<Either<Failure, bool>> deleteCastReaction({
    required Variables$Mutation$DeleteCastReaction input,
  });

  Future<Either<Failure, bool>> hasReaction({
    required CastHasReactionInput input,
  });

  Future<Either<Failure, AirstackFrame>> getNextFrame({
    required String targetUrl,
  });
}
