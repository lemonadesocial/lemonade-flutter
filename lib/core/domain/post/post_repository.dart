import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/post_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts({GetPostsInput? input});
}
