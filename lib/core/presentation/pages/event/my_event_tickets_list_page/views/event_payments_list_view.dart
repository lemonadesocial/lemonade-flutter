import 'package:app/core/domain/event/entities/event_payment.dart';
import 'package:app/core/presentation/pages/event/my_event_tickets_list_page/widgets/event_payment_list_item_widget.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPaymentListView extends StatelessWidget {
  final List<EventPayment> eventPaymentsList;
  const EventPaymentListView({
    super.key,
    required this.eventPaymentsList,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              final eventPayment = eventPaymentsList[index];
              AutoRouter.of(context).navigate(
                MyEventTicketRoute(
                  event: eventPayment.eventExpanded!,
                  eventPayment: eventPayment,
                ),
              );
            },
            child: EventPaymentListItemWidget(
              eventPayment: eventPaymentsList[index],
            ),
          );
        },
        itemCount: eventPaymentsList.length,
        separatorBuilder: (context, index) => Divider(
          color: colorScheme.outline,
          height: 1.w,
          thickness: 1.w,
        ),
      ),
    );
  }
}
