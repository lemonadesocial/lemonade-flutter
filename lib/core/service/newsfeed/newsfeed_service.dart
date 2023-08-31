import 'package:app/core/domain/newsfeed/input/get_newsfeed_input.dart';
import 'package:app/core/domain/newsfeed/newsfeed_repository.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

class NewsfeedService {
  NewsfeedService(this.newsfeedRepository);
  final NewsfeedRepository newsfeedRepository;

  Future<Either<Failure, Newsfeed>> getNewsfeed({GetNewsfeedInput? input}) {
    return newsfeedRepository.getNewsfeed(input: input);
  }
}
