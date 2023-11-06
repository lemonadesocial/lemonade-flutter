import 'package:app/__generated__/schema.schema.gql.dart';
import 'package:app/graphql/__generated__/create_post.data.gql.dart';
import 'package:app/graphql/__generated__/create_post.var.gql.dart';
import 'package:app/graphql/__generated__/get_newsfeed.data.gql.dart';
import 'package:app/graphql/__generated__/get_newsfeed.req.gql.dart';
import 'package:app/graphql/__generated__/get_posts.data.gql.dart';
import 'package:app/graphql/__generated__/get_posts.req.gql.dart';
import 'package:ferry/ferry.dart';

UpdateCacheHandler<GCreatePostData, GCreatePostVars>
    createPostUpdateCacheHandler = (
  proxy,
  response,
) {
  print("createPostUpdateCacheHandler");
  try {
    final authUserId =
        response.operationRequest.updateCacheHandlerContext?["authUserId"];
    if (!response.hasErrors) {
      final cachedNewsfeed = proxy.readQuery(GGetNewsfeedReq());
      proxy.writeQuery(
        GGetNewsfeedReq(),
        cachedNewsfeed?.rebuild(
          (b) => b
            ..getNewsfeed.posts.insert(
                  0,
                  GGetNewsfeedData_getNewsfeed_posts.fromJson(
                    response.data!.createPost.toJson(),
                  ) as GGetNewsfeedData_getNewsfeed_posts,
                ),
        ),
      );
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
          (b) => b
            ..getPosts.insert(
              0,
              GGetPostsData_getPosts.fromJson(
                response.data!.createPost.toJson(),
              ) as GGetPostsData_getPosts,
            ),
        ),
      );
    }
  } catch (e) {
    print("Error createPostUpdateCacheHandler : ${e.toString()}");
  }
};
