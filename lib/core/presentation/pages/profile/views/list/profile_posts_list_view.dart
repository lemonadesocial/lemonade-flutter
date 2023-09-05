import 'package:app/core/application/post/posts_listing_bloc/posts_listing_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePostsListView extends StatelessWidget {
  final User user;
  const ProfilePostsListView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocBuilder<PostsListingBloc, PostsListingState>(
      builder: (context, postsState) {
        return postsState.when(
          loading: () => SliverFillRemaining(
              child: Center(child: Loading.defaultLoading(context))),
          failure: () => SliverToBoxAdapter(
              child: Center(child: Text(t.common.somethingWrong))),
          fetched: (posts) {
            if (posts.isEmpty) {
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
      },
    );
  }
}
