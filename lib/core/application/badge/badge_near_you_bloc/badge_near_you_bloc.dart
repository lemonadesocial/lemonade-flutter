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

part 'badge_near_you_bloc.freezed.dart';

class BadgesNearYouBloc extends Bloc<BadgesNearYouEvent, BadgesNearYouState> {
  BadgesNearYouBloc() : super(BadgesNearYouStateInitial()) {
    on<BadgesNearYouEventFetch>(
      _onFetch,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
  }
  final BadgeService _badgeService = getIt<BadgeService>();
  final BadgeRepository _badgeRepository = getIt<BadgeRepository>();
  final GetBadgesInput defaultInput = GetBadgesInput(
    limit: 25,
    distance: 1,
  );
  late final PaginationService<Badge, GetBadgesInput?> _paginationService =
      PaginationService(
    getDataFuture: _getBadges,
  );

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

  Future<void> _onFetch(BadgesNearYouEventFetch event, Emitter emit) async {
    await _badgeService.updateMyLocation();
    final result = await _paginationService.fetch(defaultInput);
    result.fold(
      (l) => emit(BadgesNearYouState.failure()),
      (badges) => emit(
        BadgesNearYouState.fetched(
          badges: badges,
        ),
      ),
    );
  }
}

@freezed
class BadgesNearYouEvent with _$BadgesNearYouEvent {
  factory BadgesNearYouEvent.fetch({
    GetBadgesInput? input,
  }) = BadgesNearYouEventFetch;
}

@freezed
class BadgesNearYouState with _$BadgesNearYouState {
  factory BadgesNearYouState.initial() = BadgesNearYouStateInitial;
  factory BadgesNearYouState.fetched({
    required List<Badge> badges,
  }) = BadgesNearYouStateFetched;
  factory BadgesNearYouState.failure() = BadgesNearYouStateFailure;
}
