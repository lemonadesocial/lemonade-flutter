import 'package:app/__generated__/schema.schema.gql.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/ferry_client.dart';
import 'package:app/graphql/__generated__/get_posts.data.gql.dart';
import 'package:app/graphql/__generated__/get_posts.req.gql.dart';
import 'package:app/graphql/__generated__/get_posts.var.gql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';

class ProfilePostsListView extends StatelessWidget {
  final client = getIt<FerryClient>().client;
  final User user;

  ProfilePostsListView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Operation<GGetPostsData, GGetPostsVars>(
      client: client,
      operationRequest: GGetPostsReq(
        (b) => b
          ..requestId = 'getPosts'
          ..vars.input.user = GMongoID(user.userId).toBuilder()
          ..vars.limit = 15
          ..vars.skip = 0,
      ),
      builder: (context, response, error) {
        if (response!.loading) {
          return SliverFillRemaining(
            child: Center(child: Loading.defaultLoading(context)),
          );
        }
        final posts = response.data?.getPosts.toBuiltList();
        if (posts!.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyList(emptyText: t.post.noPost),
          );
        }
        return SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.xSmall,
            vertical: Spacing.xSmall,
          ),
          sliver: SliverList.separated(
            itemBuilder: (context, index) {
              return PostProfileCard(post: posts[index]);
            },
            separatorBuilder: (ctx, index) =>
                Divider(color: colorScheme.outline),
            itemCount: posts.length,
          ),
        );
      },
    );
    // return BlocBuilder<PostsListingBloc, PostsListingState>(
    //   builder: (context, postsState) {
    //     return postsState.when(
    //       loading: () => SliverFillRemaining(
    //         child: Center(child: Loading.defaultLoading(context)),
    //       ),
    //       failure: () => SliverToBoxAdapter(
    //         child: Center(child: Text(t.common.somethingWrong)),
    //       ),
    //       fetched: (posts) {
    //         if (posts.isEmpty) {
    //           return SliverFillRemaining(
    //             hasScrollBody: false,
    //             child: EmptyList(emptyText: t.post.noPost),
    //           );
    //         }
    //         return SliverPadding(
    //           padding: EdgeInsets.symmetric(
    //             horizontal: Spacing.xSmall,
    //             vertical: Spacing.xSmall,
    //           ),
    //           sliver: SliverList.separated(
    //             itemBuilder: (context, index) {
    //               return PostProfileCard(post: posts[index]);
    //             },
    //             separatorBuilder: (ctx, index) =>
    //                 Divider(color: colorScheme.outline),
    //             itemCount: posts.length,
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
