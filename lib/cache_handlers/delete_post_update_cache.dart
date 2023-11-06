import 'package:app/__generated__/schema.schema.gql.dart';
import 'package:app/graphql/__generated__/delete_post.data.gql.dart';
import 'package:app/graphql/__generated__/delete_post.var.gql.dart';
import 'package:app/graphql/__generated__/get_newsfeed.req.gql.dart';
import 'package:app/graphql/__generated__/get_posts.req.gql.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/foundation.dart';

/// this cache handler will add the newly created author to the cached list of authors
UpdateCacheHandler<GDeletePostData, GDeletePostVars>
    deletePostUpdateCacheHandler = (
  proxy,
  response,
) {
  if (kDebugMode) {
    print("deletePostUpdateCacheHandler");
  }
  try {
    final postId =
        response.operationRequest.updateCacheHandlerContext?["postId"];
    final authUserId =
        response.operationRequest.updateCacheHandlerContext?["authUserId"];
    final cachedNewsfeed = proxy.readQuery(GGetNewsfeedReq());
    if (!response.hasErrors) {
      proxy.writeQuery(
        GGetNewsfeedReq(),
        cachedNewsfeed?.rebuild(
          (b) =>
              b..getNewsfeed.posts.removeWhere((p) => p.G_id.value == postId),
        ),
      );
    }
    final cachedGetPosts = proxy.readQuery(
      GGetPostsReq(
        (b) => b
          ..vars.skip = 0
          ..vars.limit = 15
          ..vars.input.user = GMongoID(authUserId).toBuilder(),
      ),
    );
    proxy.writeQuery(
      GGetPostsReq(
        (b) => b
          ..vars.skip = 0
          ..vars.limit = 15
          ..vars.input.user = GMongoID(authUserId).toBuilder(),
      ),
      cachedGetPosts?.rebuild(
        (b) => b..getPosts.removeWhere((p) => p.G_id.value == postId),
      ),
    );
  } catch (e) {
    if (kDebugMode) {
      print("error : $e.toString()");
    }
  }
};
