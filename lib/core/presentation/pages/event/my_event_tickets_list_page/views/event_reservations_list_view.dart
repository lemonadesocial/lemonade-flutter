import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/my_event_tickets_list_page/widgets/event_reservations_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventReservationsListView extends StatelessWidget {
  final List<Event> eventsList;

  const EventReservationsListView({
    super.key,
    required this.eventsList,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return EventReservationsListItemWidget(
            event: eventsList[index],
          );
        },
        itemCount: eventsList.length,
        separatorBuilder: (context, index) => Divider(
          color: colorScheme.outline,
          height: 1.w,
          thickness: 1.w,
        ),
      ),
    );
  }
}
