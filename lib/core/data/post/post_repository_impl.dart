import 'package:app/core/data/post/dtos/post_dtos.dart';
import 'package:app/core/data/post/post_query.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final _client = getIt<AppGQL>().client;

  @override
  Future<Either<Failure, List<Post>>> getPosts({GetPostsInput? input}) async {
    final result = await _client.query(
      QueryOptions(
        document: getPostsQuery,
        variables: input?.toJson() ?? {},
        parserFn: (data) => List.from(data['getPosts'] ?? [])
            .map(
              (item) => Post.fromDto(
                PostDto.fromJson(item),
              ),
            )
            .toList(),
      ),
    );

    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, List<Post>>> getNewsfeed(int? offset) async {
    print("getNewsfeed");
    final result = await _client.query(
      QueryOptions(
          document: getNewsfeedQuery,
          parserFn: (data) {
            return List.from(data['getNewsfeed']['posts'] ?? [])
                .map(
                  (item) => Post.fromDto(
                    PostDto.fromJson(item),
                  ),
                )
                .toList();
          }
          ),
    );
    if (result.hasException) return Left(Failure());
    return Right(result.parsedData ?? []);
  }
}
