import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_pick_my_ticket_page/widgets/pick_ticket_item.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class PickMyTicketsList extends StatelessWidget {
  const PickMyTicketsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => const PickTicketItem(),
              separatorBuilder: (context, index) => SizedBox(
                height: Spacing.xSmall,
              ),
              itemCount: 2,
            ),
          ),
        ],
      ),
    );
  }
}
