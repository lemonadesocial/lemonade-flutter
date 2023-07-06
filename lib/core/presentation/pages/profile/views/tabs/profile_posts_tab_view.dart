import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/profile/views/list/profile_posts_list_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/base_sliver_tab_view.dart';
import 'package:flutter/material.dart';

class ProfilePostsTabView extends StatelessWidget {
  final User user;
  const ProfilePostsTabView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BaseSliverTabView(
      name: "posts",
      children: [
        SliverToBoxAdapter(
          child: SizedBox(height: 3),
        ),
        ProfilePostsListView(user: user),
        SliverToBoxAdapter(
          child: SizedBox(height: 92),
        ),
      ],
    );
  }
}
