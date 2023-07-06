import 'package:app/core/application/post/posts_listing_bloc/posts_listing_bloc.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePostsListView extends StatelessWidget {
  final User user;
  const ProfilePostsListView({
    super.key,
    required this.user,
  });

  GetPostsInput get input => GetPostsInput(
        user: user.id,
        limit: 100,
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsListingBloc(
        PostService(
          getIt<PostRepository>(),
        ),
      )..add(PostsListingEvent.fetch(input: input)),
      child: _ProfilePostsList(),
    );
  }
}

class _ProfilePostsList extends StatelessWidget {
  const _ProfilePostsList();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return BlocBuilder<PostsListingBloc, PostsListingState>(
      builder: (context, postsState) {
        return postsState.when(
          loading: () => SliverFillRemaining(child: Center(child: Loading.defaultLoading(context))),
          failure: () => SliverToBoxAdapter(child: Center(child: Text(t.common.somethingWrong))),
          fetched: (posts) {
            if (posts.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(child: Text(t.nft.emptyCreatedNfts)),
              );
            }
            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              sliver: SliverList.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostProfileCard(post: posts[index]);
                },
              ),
            );
          },
        );
      },
    );
  }
}
