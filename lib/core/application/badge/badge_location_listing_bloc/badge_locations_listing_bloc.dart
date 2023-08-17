import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/badge/input/badge_input.dart';
import 'package:app/core/service/badge/badge_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_locations_listing_bloc.freezed.dart';

class BadgeLocationsListingBloc extends Bloc<BadgeLocationsListingEvent, BadgeLocationsListingState> {
  BadgeLocationsListingBloc()
      : super(
          BadgeLocationsListingStateInitial(
            selectedLocation: getIt<BadgeService>().selectedLocation,
            distance: getIt<BadgeService>().distance,
          ),
        ) {
    on<BadgeLocationsListingEventFetch>(_onFetch);
    on<BadgeLocationsListingEventSelect>(_onSelect);
    on<BadgeLocationsListingEventUpdateDistance>(_onUpdateDistance);
  }
  final _badgeService = getIt<BadgeService>();
  final defaultInput = GetBadgeCitiesInput(
    skip: 0,
    limit: 25,
  );
  Future<void> _onFetch(BadgeLocationsListingEvent event, Emitter emit) async {
    final result = await _badgeService.getBadgeCities(defaultInput);
    result.fold(
      (l) => emit(BadgeLocationsListingState.failure()),
      (badgeCities) => emit(
        BadgeLocationsListingState.fetched(
          locations: badgeCities.map((city) => BadgeLocation.city(city: city)).toList(),
          selectedLocation: _badgeService.selectedLocation,
          distance: _badgeService.distance,
        ),
      ),
    );
  }

  void _onSelect(BadgeLocationsListingEventSelect event, emit) {
    _badgeService.selectLocation(event.location);
    state.whenOrNull(
      fetched: (locations, _, distance) {
        emit(
          BadgeLocationsListingState.fetched(
            locations: locations,
            selectedLocation: _badgeService.selectedLocation,
            distance: distance,
          ),
        );
      },
    );
  }

  void _onUpdateDistance(BadgeLocationsListingEventUpdateDistance event, emit) {
    _badgeService.updateDistance(event.distance);
    state.whenOrNull(
      fetched: (locations, _, distance) {
        emit(
          BadgeLocationsListingState.fetched(
            locations: locations,
            selectedLocation: _badgeService.selectedLocation,
            distance: _badgeService.distance,
          ),
        );
      },
    );
  }
}

@freezed
class BadgeLocationsListingEvent with _$BadgeLocationsListingEvent {
  factory BadgeLocationsListingEvent.fetch() = BadgeLocationsListingEventFetch;
  factory BadgeLocationsListingEvent.select({
    BadgeLocation? location,
  }) = BadgeLocationsListingEventSelect;
  factory BadgeLocationsListingEvent.updateDistance({
    required double distance,
  }) = BadgeLocationsListingEventUpdateDistance;
}

@freezed
class BadgeLocationsListingState with _$BadgeLocationsListingState {
  factory BadgeLocationsListingState.initial({
    BadgeLocation? selectedLocation,
    double? distance,
  }) = BadgeLocationsListingStateInitial;
  factory BadgeLocationsListingState.fetched({
    required List<BadgeLocation> locations,
    BadgeLocation? selectedLocation,
    required double distance,
  }) = BadgeLocationsListingStateFetched;
  factory BadgeLocationsListingState.failure() = BadgeLocationsListingStateFailure;
}
