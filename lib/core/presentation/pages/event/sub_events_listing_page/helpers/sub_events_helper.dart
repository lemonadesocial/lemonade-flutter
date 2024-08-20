import 'package:app/core/domain/event/entities/event.dart';
import 'package:calendar_view/calendar_view.dart';

List<CalendarEventData> getCalendarEvents(List<Event> events) {
  return events.map((event) {
    DateTime eventStartTime = event.start!.toLocal();
    DateTime eventEndTime = event.end!.toLocal();

    bool isFullDayEvent = eventEndTime.year >= eventStartTime.year &&
        eventEndTime.month >= eventStartTime.month &&
        eventEndTime.day > eventStartTime.day;

    if (eventStartTime.hour == eventEndTime.hour &&
        eventStartTime.minute == eventEndTime.minute) {
      eventEndTime = eventEndTime.add(const Duration(hours: 1, minutes: 30));
    }

    return CalendarEventData(
      // date and start Date decide if the event is full day event or not
      date: event.start!.toLocal(),
      endDate: event.end!.toLocal(),
      // start and end time won't care on year, month, day
      startTime: isFullDayEvent ? null : eventStartTime,
      endTime: isFullDayEvent ? null : eventEndTime,
      // use id as a title for calendar view event for the library to identify the event
      title: event.id ?? '',
      description: event.description,
      event: event.toJson(),
    );
  }).toList();
}

bool getSubEventByFilter(
  Event event, {
  required List<String> selectedHosts,
  required List<String> selectedTags,
}) {
  final eventHostId = event.host;
  final hostIncluded =
      selectedHosts.isEmpty ? true : selectedHosts.contains(eventHostId);
  final tagIncluded = selectedTags.isEmpty
      ? true
      : (event.tags ?? [])
          .toSet()
          .intersection(selectedTags.toSet())
          .isNotEmpty;
  if (tagIncluded && hostIncluded) {
    return true;
  }
  return false;
}
