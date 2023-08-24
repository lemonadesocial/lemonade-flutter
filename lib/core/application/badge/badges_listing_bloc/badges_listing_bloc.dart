import 'package:app/core/domain/badge/badge_repository.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/badge/input/badge_input.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/badge/badge_service.dart';
import 'package:app/core/service/pagination/pagination_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'badges_listing_bloc.freezed.dart';

class BadgesListingBloc extends Bloc<BadgesListingEvent, BadgesListingState> {
  BadgesListingBloc() : super(BadgesListingStateInitial()) {
    _createInput();
    on<BadgesListingEventFetch>(_onFetch);
    on<BadgesListingEventRefresh>(
      _onRefresh,
      transformer: (events, mapper) {
        return events.debounceTime(const Duration(milliseconds: 300)).asyncExpand(mapper);
      },
    );
  }
  final BadgeService _badgeService = getIt<BadgeService>();
  final BadgeRepository _badgeRepository = getIt<BadgeRepository>();
  late GetBadgesInput defaultInput;
  late final PaginationService<Badge, GetBadgesInput?> _paginationService = PaginationService(
    getDataFuture: _getBadges,
  );

  void _createInput() {
    defaultInput = GetBadgesInput(
      limit: 25,
      list: _badgeService.selectedCollections.isNotEmpty
          ? _badgeService.selectedCollections.map((item) => item.id ?? '').toList()
          : null,
      city: _badgeService.selectedLocation?.badgeCity?.city,
      country: _badgeService.selectedLocation?.badgeCity?.country,
      distance: _badgeService.selectedLocation != null && _badgeService.selectedLocation!.isMyLocation
          ? _badgeService.distance
          : null,
    );
  }

  Future<Either<Failure, List<Badge>>> _getBadges(
    skip,
    endReached, {
    GetBadgesInput? input,
  }) async {
    return _badgeRepository.getBadges(
      input?.copyWith(skip: skip, limit: 25),
      geoPoint: _badgeService.geoPoint,
    );
  }

  Future<void> _onFetch(BadgesListingEventFetch event, Emitter emit) async {
    await _badgeService.updateMyLocation();
    final result = await _paginationService.fetch(defaultInput);
    result.fold(
      (l) => emit(BadgesListingState.failure()),
      (badges) => emit(
        BadgesListingState.fetched(
          badges: badges,
        ),
      ),
    );
  }

  Future<void> _onRefresh(BadgesListingEventRefresh event, Emitter emit) async {
    await _badgeService.updateMyLocation();
    emit(
      BadgesListingState.initial(),
    );
    _createInput();
    final result = await _paginationService.refresh(defaultInput);
    result.fold(
      (l) => emit(BadgesListingState.failure()),
      (badges) => emit(
        BadgesListingState.fetched(
          badges: badges,
        ),
      ),
    );
  }
}

@freezed
class BadgesListingEvent with _$BadgesListingEvent {
  factory BadgesListingEvent.fetch({
    GetBadgesInput? input,
  }) = BadgesListingEventFetch;
  factory BadgesListingEvent.refresh({
    GetBadgesInput? input,
  }) = BadgesListingEventRefresh;
}

@freezed
class BadgesListingState with _$BadgesListingState {
  factory BadgesListingState.initial() = BadgesListingStateInitial;
  factory BadgesListingState.fetched({
    required List<Badge> badges,
  }) = BadgesListingStateFetched;
  factory BadgesListingState.failure() = BadgesListingStateFailure;
}
