import 'package:app/core/domain/newsfeed/input/get_newsfeed_input.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class NewsfeedRepository {
  Future<Either<Failure, Newsfeed>> getNewsfeed({GetNewsfeedInput? input});
}
