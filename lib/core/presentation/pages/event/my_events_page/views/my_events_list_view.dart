import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/my_events_page/widgets/my_events_empty_widget.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/home_event_card.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class MyEventsListView extends StatelessWidget {
  final List<Event> events;
  final MyEventsEmptyWidgetType emptyType;

  const MyEventsListView({
    super.key,
    required this.events,
    required this.emptyType,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return MyEventsEmptyWidget(type: emptyType);
    }

    return ListView.separated(
      padding: EdgeInsets.all(Spacing.smMedium),
      itemBuilder: (context, index) {
        // TODO: Gonna replace soon
        return HomeEventCard(event: events[index]);
        // return MyEventsListItem(
        //   event: events[index],
        // );
      },
      separatorBuilder: (context, index) => SizedBox(height: Spacing.s2),
      itemCount: events.length,
    );
  }
}
