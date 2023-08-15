import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_locations_listing_bloc.freezed.dart';

class BadgeLocationsListingBloc extends Bloc<BadgeLocationsListingEvent, BadgeLocationsListingState> {
  BadgeLocationsListingBloc() : super(BadgeLocationsListingStateInitial()) {
    // on<BadgeLocationsListingEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }
}

@freezed
class BadgeLocationsListingEvent with _$BadgeLocationsListingEvent {
  factory BadgeLocationsListingEvent.fetch() = BadgeLocationsListingEventFetch;
  factory BadgeLocationsListingEvent.select({
    required BadgeCity location,
  }) = BadgeLocationsListingEventSelect;
}

@freezed
class BadgeLocationsListingState with _$BadgeLocationsListingState {
  factory BadgeLocationsListingState.initial() = BadgeLocationsListingStateInitial;
  factory BadgeLocationsListingState.fetched({
    required List<BadgeCity> locations,
    required BadgeList selectedLocation,
  }) = BadgeLocationsListingStateFetched;
  factory BadgeLocationsListingState.failure() = BadgeLocationsListingStateFailure;
}
