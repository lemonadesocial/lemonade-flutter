import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:dartz/dartz.dart';

class HostingEventsListingBloc
    extends BaseEventListingBloc<GetHostingEventsInput> {
  HostingEventsListingBloc(
    final EventService eventService, {
    required final GetHostingEventsInput defaultInput,
  }) : super(eventService, defaultInput: defaultInput);

  @override
  Future<Either<Failure, List<Event>>> getEvents(
    int skip,
    bool endReached, {
    required GetHostingEventsInput input,
  }) async {
    return eventService.getHostingEvents(input: input.copyWith(skip: skip));
  }
}
