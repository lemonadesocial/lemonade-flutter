import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

import '../../application/post/create_post_bloc/create_post_bloc.dart';

class PostService {
  final PostRepository postRepository;

  PostService(this.postRepository);

  Future<Either<Failure, List<Post>>> getPosts({GetPostsInput? input}) {
    return postRepository.getPosts(input: input);
  }

  Future<Either<Failure, bool>> createPost({
    required String postDescription,
    required PostPrivacy postPrivacy,
    String? imageRefId,
  }) =>
      postRepository.createNewPost(
        postDescription: postDescription,
        postPrivacy: postPrivacy,
        imageRefId: imageRefId,
      );
}
