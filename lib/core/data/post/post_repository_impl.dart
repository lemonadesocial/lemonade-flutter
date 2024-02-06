import 'package:app/core/application/post/create_post_bloc/create_post_bloc.dart';
import 'package:app/core/data/post/dtos/post_comment_dto.dart';
import 'package:app/core/data/post/dtos/post_dtos.dart';
import 'package:app/core/data/post/mutations/create_post_comment_mutation.dart';
import 'package:app/core/data/post/mutations/post_reaction_mutation.dart';
import 'package:app/core/data/post/query/post_query.dart';
import 'package:app/core/data/post/query/post_comments_query.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/create_post_comment_input.dart';
import 'package:app/core/domain/post/input/get_post_comments_input.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/domain/post/input/post_reaction_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:matrix/matrix.dart';

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
  Future<Either<Failure, Post>> createNewPost({
    required String postDescription,
    required PostPrivacy postPrivacy,
    PostRefType? postRefType,
    String? postRefId,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: createPostQuery,
        variables: {
          'text': postDescription,
          'visibility': postPrivacy.name.toUpperCase(),
          'ref_type': postRefType?.name.toUpperCase(),
          'ref_id': postRefId,
        }..removeWhere((key, value) => value == null),
        parserFn: (data) => Post.fromDto(
          PostDto.fromJson(data['createPost']),
        ),
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData!);
  }

  @override
  Future<Either<Failure, bool>> togglePostReaction({
    required PostReactionInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: togglePostReactionMutation,
        variables: {
          'input': input.toJson(),
        },
        update: (cache, result) {
          if (result == null) return;
          if (result.hasException == true) return;

          final cachePostFragment = cache.readFragment(
            FragmentRequest(
              fragment: Fragment(
                document: gql(postFragment),
                fragmentName: 'postFragment',
              ),
              idFields: {
                '__typename': 'Post',
                'id': input.post,
              },
            ),
          );
          if (cachePostFragment != null) {
            final postDto = PostDto.fromJson(cachePostFragment);
            final updatedPostDto = postDto.copyWith(
              hasReaction: input.active,
              reactions:
                  ((postDto.reactions ?? 0) + (input.active ? 1 : -1)).toInt(),
            );
            cache.writeFragment(
              FragmentRequest(
                fragment: Fragment(
                  document: gql(postFragment),
                  fragmentName: 'postFragment',
                ),
                idFields: {
                  '__typename': 'Post',
                  'id': input.post,
                },
              ),
              data: updatedPostDto.toJson(),
              broadcast: false,
            );
          }
        },
      ),
    );

    if (result.hasException) return Left(Failure());

    return Right(result.data?['toggleReaction'] == true);
  }

  @override
  Future<Either<Failure, List<PostComment>>> getPostComments({
    required GetPostCommentsInput input,
  }) async {
    final result = await _client.query(
      QueryOptions(
        document: getPostCommentsQuery,
        variables: input.toJson(),
        parserFn: (data) => List.from(data['getComments'] ?? [])
            .map((item) => PostComment.fromDto(PostCommentDto.fromJson(item)))
            .toList(),
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }

    return Right(result.parsedData ?? []);
  }

  @override
  Future<Either<Failure, PostComment>> createPostComment({
    required CreatePostCommentInput input,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: createPostCommentMutation,
        variables: input.toJson(),
        parserFn: (data) =>
            PostComment.fromDto(PostCommentDto.fromJson(data['createComment'])),
        update: (cache, result) {
          if (result == null) return;
          if (result.hasException) return;

          final queryData = cache.readQuery(
            Request(
              operation: Operation(document: getPostCommentsQuery),
              variables: {
                'skip': 0,
                'post': input.post,
              },
            ),
          );
          if (queryData == null) return;
          queryData.update(
            'getComments',
            (value) => [result.data?['createComment'], ...(value ?? [])],
          );
          final updatedData = queryData.copy();
          cache.writeQuery(
            Request(
              operation: Operation(
                document: getPostCommentsQuery,
                operationName: 'GetComments',
              ),
              variables: {
                'skip': 0,
                'post': input.post,
              },
            ),
            data: updatedData,
          );
        },
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }

    return Right(result.parsedData!);
  }
}
