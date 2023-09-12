import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app/core/application/post/create_post_bloc/create_post_bloc.dart';

class PostService {
  final PostRepository postRepository;

  PostService(this.postRepository);

  Future<Either<Failure, List<Post>>> getPosts({GetPostsInput? input}) {
    return postRepository.getPosts(input: input);
  }

  Future<Either<Failure, Post>> createPost({
    required String postDescription,
    required PostPrivacy postPrivacy,
    PostRefType? postRefType,
    String? postRefId,
  }) =>
      postRepository.createNewPost(
        postDescription: postDescription,
        postPrivacy: postPrivacy,
        postRefType: postRefType,
        postRefId: postRefId,
      );

  Future<Either<Failure, String>> uploadImage(
    XFile file, {
    required String directory,
  }) =>
      postRepository.uploadImage(file, directory);
}
