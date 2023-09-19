import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_ticket_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTicketsList extends StatelessWidget {
  const SelectTicketsList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => const SelectTicketItem(),
              separatorBuilder: (context, index) => Divider(
                height: 1.w,
                thickness: 1.w,
                color: colorScheme.onPrimary.withOpacity(0.05),
              ),
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
