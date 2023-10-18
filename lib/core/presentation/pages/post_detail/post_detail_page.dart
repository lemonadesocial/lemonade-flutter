import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/presentation/pages/post_detail/widgets/post_comment_tile.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/post/post_profile_card_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PostDetailPage extends StatelessWidget {
  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        leading: const LemonBackButton(),
        title: t.post.post,
      ),
      backgroundColor: colorScheme.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        child: Column(
          children: [
            PostProfileCard(
              post: post,
              isDetailPost: true,
            ),
            SizedBox(height: Spacing.small),
            Divider(color: colorScheme.outline),
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PostCommentTile(
                  userId: 'userId',
                  userName: 'Jonny Cage',
                  comment: 'That is a good one!',
                  createTime: DateTime.now(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
