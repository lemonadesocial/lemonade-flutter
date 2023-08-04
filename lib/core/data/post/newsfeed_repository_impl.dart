import 'package:app/core/data/post/dtos/newsfeed_dtos.dart';
import 'package:app/core/data/post/post_query.dart';
import 'package:app/core/domain/newsfeed/input/get_newsfeed_input.dart';
import 'package:app/core/domain/newsfeed/newsfeed_repository.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NewsfeedRepository)
class NewsfeedRepositoryImpl implements NewsfeedRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, Newsfeed>> getNewsfeed(
      {GetNewsfeedInput? input}) async {
    if (input?.offset == 0) {
      final result = await _client.query(
        QueryOptions(
            document: getNewsfeedQuery,
            parserFn: (data) {
              return Newsfeed.fromDto(
                  NewsfeedDto.fromJson(data['getNewsfeed']));
            }),
      );
      if (result.hasException) return Left(Failure());
      return Right(result.parsedData!);
    }
    final result = await _client.query(
      QueryOptions(
          document: getNewsfeedQuery,
          variables: input?.toJson() ?? {},
          parserFn: (data) {
            if (data['getNewsfeed'] == null) {
              return Newsfeed();
            }
            return Newsfeed.fromDto(NewsfeedDto.fromJson(data['getNewsfeed']));
          }),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData!);
  }
}
