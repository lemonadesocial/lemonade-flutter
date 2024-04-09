import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class EventPublishTicketsChecklistItem extends StatelessWidget {
  final bool fulfilled;
  const EventPublishTicketsChecklistItem({
    super.key,
    required this.fulfilled,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return CheckListItemBaseWidget(
      onTap: () => AutoRouter.of(context).push(
        const EventTicketTierSettingRoute(),
      ),
      title: t.event.eventPublish.addTickets,
      icon: Assets.icons.icTicket,
      fulfilled: fulfilled,
    );
  }
}
