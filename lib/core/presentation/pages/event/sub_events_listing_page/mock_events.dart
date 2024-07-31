import 'package:app/core/domain/event/entities/event.dart';
import 'package:calendar_view/calendar_view.dart';

final _now = DateTime.now();

final lemonadeEvents = [
  Event(
    title: "Project meetings",
    description: "Today is project meeting.",
    start: _now,
    end: _now,
  ),
  Event(
    title: "Football Tournament",
    description: "Go to football tournament.",
    start: _now,
    end: _now,
  ),
];

List<CalendarEventData<Map<String, dynamic>>> mock_events =
    lemonadeEvents.map((e) {
  return CalendarEventData(
    // date and start Date decide if the event is full day event or not
    date: e.start!,
    endDate: e.end!,
    // start and end time won't care on year, month, day
    startTime: DateTime(0, 0, 0, 15),
    endTime: DateTime(0, 0, 0, 17),
    title: e.title!,
    description: e.description,
    event: e.toJson(),
  );
}).toList();
