import 'package:app/core/application/post/create_post_bloc/create_post_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/data/post/dtos/post_dtos.dart';
import 'package:app/core/data/post/post_query.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

import 'package:app/core/oauth/oauth.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final _client = getIt<AppGQL>().client;
  final _legacyClient = Dio(BaseOptions(baseUrl: AppConfig.legacyApi));

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
  Future<Either<Failure, String>> uploadImage(
    XFile file,
    String directory,
  ) async {
    final token = await getIt<AppOauth>().getTokenForGql();
    final mimeType = lookupMimeType(file.path);
    final mime = mimeType!.split('/')[0];
    final type = mimeType.split('/')[1];
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType(mime, type),
      ),
      'directory': directory,
    });
    final response = await _legacyClient.post(
      '/api/v1/file',
      queryParameters: {
        'blocking': true,
      },
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': '*/*',
          'Connection': 'keep-alive',
          'Authorization': token,
        },
      ),
      data: formData,
    );

    if (response.statusCode != 200) {
      return Left(Failure());
    }
    return Right(response.data['_id']);
  }
}
