import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

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
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';

import '../../oauth/oauth.dart';

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
  Future<Either<Failure, bool>> createNewPost({
    required String postDescription,
    required PostPrivacy postPrivacy,
    String? imageRefId,
  }) async {
    final result = await _client.mutate(
      MutationOptions(
        document: createPostQuery,
        variables: {
          'text': postDescription,
          'visibility': postPrivacy.name.toUpperCase(),
        },
        parserFn: (data) => data['setUserWallet'],
      ),
    );

    if (result.hasException) {
      return Left(Failure());
    }
    return Right(result.parsedData == true);
  }

  @override
  Future<Either<Failure, String>> uploadImage(String filePath) async {
    final token = await getIt<AppOauth>().getTokenForGql();

    /// Using legacy HTTP method from Dart package
    // final postUri = Uri.parse('${AppConfig.legacyApi}/v1/file?blocking=true');
    // final request = http.MultipartRequest('POST', postUri);
    // request.files.add(
    //   await http.MultipartFile.fromPath(
    //     'file',
    //     filePath,
    //     filename: filePath.split('/').last,
    //   ),
    // );
    // request.headers.addAll(
    //   {
    //     'Content-Type': 'multipart/form-data',
    //     'Accept': '*/*',
    //     'Connection': 'keep-alive',
    //     'Authorization': token,
    //   },
    // );
    // final response = await request.send();

    /// Using Dio package
    // final formData = FormData.fromMap({
    //   'file': await MultipartFile.fromFile(
    //     filePath,
    //     filename: filePath.split('/').last,
    //   ),
    //   'directory': 'post',
    // });
    // final response = await _legacyClient.post(
    //   '/v1/file',
    //   queryParameters: {
    //     'blocking': true,
    //   },
    //   options: Options(
    //     headers: {
    //       'Content-Type': 'multipart/form-data',
    //       'Accept': '*/*',
    //       'Connection': 'keep-alive',
    //       'Authorization': token,
    //     },
    //   ),
    //   data: formData,
    // );
    //
    // print("response: ${response.statusCode}");
    // if (response.statusCode != 200) {
    //   return Left(Failure());
    // }
    // return Right('');
  }
}
