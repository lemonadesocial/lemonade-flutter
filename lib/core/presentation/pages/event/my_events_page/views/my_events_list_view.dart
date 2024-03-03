import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/my_events_page/widgets/my_events_list_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class MyEventsListView extends StatelessWidget {
  final List<Event> events;

  const MyEventsListView({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    if (events.isEmpty) {
      return EmptyList(
        emptyText: t.event.empty.myEvents,
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(Spacing.smMedium),
      itemBuilder: (context, index) {
        return MyEventsListItem(
          event: events[index],
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: Spacing.superExtraSmall),
      itemCount: events.length,
    );
  }
}
