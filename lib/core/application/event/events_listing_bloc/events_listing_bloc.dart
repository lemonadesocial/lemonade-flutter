import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:dartz/dartz.dart';

class EventsListingBloc extends BaseEventListingBloc<GetEventsInput> {
  EventsListingBloc(
    final EventService eventService, {
    required GetEventsInput defaultInput,
  }) : super(eventService, defaultInput: defaultInput);

  @override
  Future<Either<Failure, List<Event>>> getEvents(
    int skip,
    bool endReached, {
    required GetEventsInput input,
  }) async {
    return eventService.getEvents(input: input.copyWith(skip: skip));
  }
}
