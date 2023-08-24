import 'package:app/core/domain/badge/badge_repository.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/badge/input/badge_input.dart';
import 'package:app/core/service/badge/badge_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_detail_bloc.freezed.dart';

class BadgeDetailBloc extends Bloc<BadgeDetailEvent, BadgeDetailState> {
  BadgeDetailBloc({required this.defaultBadge})
      : super(
          BadgeDetailState(
            badge: defaultBadge,
          ),
        ) {
    on<BadgeDetailEventFetch>(_onFetch);
  }
  final Badge defaultBadge;
  final _badgeRepository = getIt<BadgeRepository>();
  final _badgeService = getIt<BadgeService>();

  Future<void> _onFetch(BadgeDetailEventFetch event, Emitter emit) async {
    emit(state.copyWith(isLoading: true));
    await _badgeService.updateMyLocation();
    final result = await _badgeRepository.getBadges(
      GetBadgesInput(
        id: [defaultBadge.id!],
        skip: 0,
        limit: 1,
      ),
      geoPoint: _badgeService.geoPoint,
    );

    result.fold((l) => null, (badges) {
      if (badges.isEmpty) return;
      emit(
        state.copyWith(badge: badges[0], isLoading: false),
      );
    });
  }
}

@freezed
class BadgeDetailState with _$BadgeDetailState {
  const factory BadgeDetailState({
    required Badge badge,
    @Default(false) isLoading,
  }) = _BadgeDetailState;
}

@freezed
class BadgeDetailEvent with _$BadgeDetailEvent {
  const factory BadgeDetailEvent.fetch() = BadgeDetailEventFetch;
}
