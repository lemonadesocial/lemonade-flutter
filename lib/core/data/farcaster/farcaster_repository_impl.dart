import 'package:app/core/config.dart';
import 'package:app/core/data/farcaster/dtos/farcaster_account_key_request_dto.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_account_key_request.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_channel.dart';
import 'package:app/core/domain/farcaster/entities/farcaster_signed_key_request.dart';
import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_cast.graphql.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_farcaster_account_key.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: FarcasterRepository)
class FarcasterRepositoryImpl implements FarcasterRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, FarcasterAccountKeyRequest>>
      createFarcasterAccountKey() async {
    final result = await _client.mutate$CreateFarcasterAccountKey();
    if (result.hasException ||
        result.parsedData?.createFarcasterAccountKey.account_key_request ==
            null) {
      return Left(Failure());
    }
    return Right(
      FarcasterAccountKeyRequest.fromDto(
        FarcasterAccountKeyRequestDto.fromJson(
          result.parsedData!.createFarcasterAccountKey.account_key_request
              .toJson(),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, FarcasterSignedKeyRequest>> getConnectRequest(
    String token,
  ) async {
    try {
      final result = await Dio()
          .get('https://api.warpcast.com/v2/signed-key-request?token=$token');
      if (result.statusCode == 200) {
        final signedKeyRequest = FarcasterSignedKeyRequest.fromJson(
          (result.data as Map<String, dynamic>)['result']['signedKeyRequest'],
        );

        return Right(signedKeyRequest);
      }
      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, bool>> createCast({
    required Variables$Mutation$CreateCast input,
  }) async {
    final result = await _client.mutate$CreateCast(
      Options$Mutation$CreateCast(variables: input),
    );
    if (result.hasException || result.parsedData?.createCast == null) {
      return Left(Failure());
    }
    return Right(result.parsedData!.createCast);
  }

  @override
  Future<Either<Failure, List<FarcasterChannel>>> getChannels({
    required int fid,
  }) async {
    try {
      final result = await Dio()
          .get('${AppConfig.webUrl}/api/farcaster/channels?fid=$fid');

      if (result.statusCode == 200) {
        final rawChannels = (result.data as Map<String, dynamic>)['result']
            ['channels'] as List<dynamic>;
        return Right(
          rawChannels.map((item) => FarcasterChannel.fromJson(item)).toList(),
        );
      }

      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }
}
