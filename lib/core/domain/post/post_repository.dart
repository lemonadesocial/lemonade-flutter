import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/create_post_comment_input.dart';
import 'package:app/core/domain/post/input/get_post_comments_input.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/domain/post/input/post_reaction_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

import 'package:app/core/application/post/create_post_bloc/create_post_bloc.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts({GetPostsInput? input});

  Future<Either<Failure, Post>> createNewPost({
    required String postDescription,
    required PostPrivacy postPrivacy,
    PostRefType? postRefType,
    String? postRefId,
  });

  Future<Either<Failure, bool>> togglePostReaction({
    required PostReactionInput input,
  });

  Future<Either<Failure, List<PostComment>>> getPostComments({
    required GetPostCommentsInput input,
  });

  Future<Either<Failure, PostComment>> createPostComment({
    required CreatePostCommentInput input,
  });
}
