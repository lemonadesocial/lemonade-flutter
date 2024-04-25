import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_chat_page/widgets/collaborator_chat_list.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_chat_page/widgets/horizontal_collaborator_likes_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CollaboratorChatPage extends StatelessWidget {
  const CollaboratorChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.collaborator.chat,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HorizontalCollaboratorLikesList(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: Spacing.large,
            ),
          ),
          const CollaboratorChatList(),
        ],
      ),
    );
  }
}
