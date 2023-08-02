import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts({GetPostsInput? input});
  Future<Either<Failure, List<Post>>> getNewsfeed(int? offset);
}
