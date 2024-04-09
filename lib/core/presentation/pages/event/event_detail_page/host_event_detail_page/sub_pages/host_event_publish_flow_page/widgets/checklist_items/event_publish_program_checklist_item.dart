import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';

class EventPublishProgramChecklistItem extends StatelessWidget {
  const EventPublishProgramChecklistItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return CheckListItemBaseWidget(
      title: t.event.eventPublish.addProgram,
      icon: Assets.icons.icProgram,
      fullfiled: false,
    );
  }
}
