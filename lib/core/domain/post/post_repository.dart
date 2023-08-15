import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/post/create_post_bloc/create_post_bloc.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts({GetPostsInput? input});

  Future<Either<Failure, bool>> createNewPost({
    required String postDescription,
    required PostPrivacy postPrivacy,
    PostRefType? postRefType,
    String? postRefId,
  });

  Future<Either<Failure, String>> uploadImage(XFile file);
}
