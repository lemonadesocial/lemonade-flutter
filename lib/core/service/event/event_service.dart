import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/utils/date_utils.dart';
import 'package:dartz/dartz.dart';

class EventService {
  final EventRepository eventRepository;
  EventService(this.eventRepository);

  Future<Either<Failure, List<Event>>> getEvents({
    required GetEventsInput input,
  }) async {
    return await eventRepository.getEvents(input: input);
  }

  Future<Either<Failure, List<Event>>> getHomeEvents({
    required GetHomeEventsInput input,
  }) async {
    return await eventRepository.getHomeEvents(input: input);
  }

  Future<Either<Failure, List<Event>>> getHostingEvents({
    required GetHostingEventsInput input,
  }) async {
    return await eventRepository.getHostingEvents(input: input);
  }

  List<Event> filterEventByTime({
    required List<Event> source,
    EventTimeFilter? selectedFilter,
  }) {
    if (selectedFilter == null) return source;
    // Filtering logic based on the selected filter
    switch (selectedFilter) {
      case EventTimeFilter.today:
        return source.where((event) => DateUtils.isToday(event.start)).toList();

      case EventTimeFilter.tomorrow:
        return source
            .where((event) => DateUtils.isTomorrow(event.start))
            .toList();

      case EventTimeFilter.thisWeek:
        return source
            .where((event) => DateUtils.isThisWeek(event.start))
            .toList();

      case EventTimeFilter.thisWeekend:
        return source
            .where((event) => DateUtils.isThisWeekend(event.start))
            .toList();

      case EventTimeFilter.nextWeek:
        return source
            .where((event) => DateUtils.isNextWeek(event.start))
            .toList();

      case EventTimeFilter.nextWeekend:
        return source
            .where((event) => DateUtils.isNextWeekend(event.start))
            .toList();

      case EventTimeFilter.nextMonth:
        return source
            .where((event) => DateUtils.isNextMonth(event.start))
            .toList();

      default:
        return source;
    }
  }
}
