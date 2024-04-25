import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_likes_page/widgets/collborator_like_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CollaboratorLikesPage extends StatelessWidget {
  const CollaboratorLikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(title: t.collaborator.likes),
      body: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const CollboratorLikeItem();
            },
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.xSmall),
          ),
        ],
      ),
    );
  }
}
