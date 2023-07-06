import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/post_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

class PostService {
  final PostRepository postRepository;
  PostService(this.postRepository);

  Future<Either<Failure, List<Post>>> getPosts({GetPostsInput? input}) {
    return postRepository.getPosts(input: input);
  }
}
