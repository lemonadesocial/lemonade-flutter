import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/application/post/posts_listing_bloc/posts_listing_bloc.dart';
import 'package:app/core/domain/post/input/get_posts_input.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_posts_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/base_sliver_tab_view.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProfilePostsTabView extends StatelessWidget {
  ProfilePostsTabView({
    super.key,
    required this.user,
  });

  final User user;

  GetPostsInput get input =>
      GetPostsInput(
        user: user.id,
        limit: 10,
      );

  late final postsListingBloc = PostsListingBloc(
    PostService(
      getIt<PostRepository>(),
    ),
    defaultInput: input,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => postsListingBloc,
      child: VisibilityDetector(
        key: const Key('ProfilePostsTabViewDetector'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 1) {
            // Whenever this widget is appeared on screen,
            // fetch latest list
            postsListingBloc.add(PostsListingEvent.refresh());
          }
        },
        child: BaseSliverTabView(
          name: 'posts',
          children: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 3),
            ),
            // ProfilePostsListView(user: user),
            BlocListener<ScrollNotificationBloc, ScrollNotificationState>(
              listener: (context, scrollState) {
                scrollState.whenOrNull(
                  endReached: () {
                    postsListingBloc.add(PostsListingEvent.fetch());
                  },
                );
              },
              child: ProfilePostsListView(user: user),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 92),
            ),
          ],
        ),
      ),
    );
  }
}
