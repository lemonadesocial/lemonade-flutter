import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/date_utils.dart';
import 'package:dartz/dartz.dart';

class EventService {
  final EventRepository eventRepository;
  EventService(this.eventRepository);

  Future<Either<Failure, List<Event>>> getHomeEvents({
    String query = '',
    int limit = 100,
    double latitude = 0,
    double longitude = 0,
    EventTense tense = EventTense.Future,
  }) async {
    return await eventRepository.getHomeEvents();
  }

  List<Event> filterEventByTime({
    required List<Event> source,
    EventTimeFilter? selectedFilter,
  }) {
    if(selectedFilter == null) return source;
    // Filtering logic based on the selected filter
    switch (selectedFilter) {
      case EventTimeFilter.today:
        return source.where((event) => DateUtils.isToday(event.start)).toList();

      case EventTimeFilter.tomorrow:
        return source.where((event) => DateUtils.isTomorrow(event.start)).toList();

      case EventTimeFilter.thisWeek:
        return source.where((event) => DateUtils.isThisWeek(event.start)).toList();

      case EventTimeFilter.thisWeekend:
        return source.where((event) => DateUtils.isThisWeekend(event.start)).toList();

      case EventTimeFilter.nextWeek:
        return source.where((event) => DateUtils.isNextWeek(event.start)).toList();

      case EventTimeFilter.nextWeekend:
        return source.where((event) => DateUtils.isNextWeekend(event.start)).toList();

      case EventTimeFilter.nextMonth:
        return source.where((event) => DateUtils.isNextMonth(event.start)).toList();

      default:
        return source;
    }
  }
}
