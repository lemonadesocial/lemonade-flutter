import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

class HomeEventListingBloc extends BaseEventListingBloc<GetHomeEventsInput> {
  HomeEventListingBloc(
    super.eventService, {
    required super.defaultInput,
  });

  @override
  Future<Either<Failure, List<Event>>> getEvents(
    int skip,
    bool endReached, {
    required GetHomeEventsInput input,
  }) async {
    return eventService.getHomeEvents(input: input.copyWith(skip: skip));
  }
}
