import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';

class EventPublishCollectiblesChecklistItem extends StatelessWidget {
  final bool fulfilled;
  const EventPublishCollectiblesChecklistItem({
    super.key,
    required this.fulfilled,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return CheckListItemBaseWidget(
      onTap: () => SnackBarUtils.showComingSoon(),
      title: t.event.eventPublish.addCollectible,
      icon: Assets.icons.icCrystal,
      fulfilled: fulfilled,
    );
  }
}
