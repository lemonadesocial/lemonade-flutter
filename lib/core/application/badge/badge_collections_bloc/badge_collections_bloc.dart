import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/badge/input/badge_input.dart';
import 'package:app/core/service/badge/badge_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_collections_bloc.freezed.dart';

class BadgeCollectionsBloc extends Bloc<BadgeCollectionsEvent, BadgeCollectionsState> {
  BadgeCollectionsBloc() : super(BadgeCollectionsStateInitial()) {
    on<BadgeCollectionsEventFetch>(_onFetch);
  }
  final BadgeService _badgeService = getIt<BadgeService>();

  Future<void> _onFetch(BadgeCollectionsEventFetch event, Emitter emit) async {
    final result = await _badgeService.getBadgeCollections(
      GetBadgeListsInput(
        skip: 0,
        limit: 100,
      ),
    );
    result.fold(
      (l) => emit(BadgeCollectionsState.failure()),
      (collections) => BadgeCollectionsState.fetched(
        collections: collections,
        selectedCollections: _badgeService.selectedCollections,
      ),
    );
  }
}

@freezed
class BadgeCollectionsEvent with _$BadgeCollectionsEvent {
  factory BadgeCollectionsEvent.fetch() = BadgeCollectionsEventFetch;
  factory BadgeCollectionsEvent.select({
    required BadgeList collection,
  }) = BadgeCollectionsEventSelect;
  factory BadgeCollectionsEvent.deselect({
    required BadgeList collection,
  }) = BadgeCollectionsEventDeselect;
}

@freezed
class BadgeCollectionsState with _$BadgeCollectionsState {
  factory BadgeCollectionsState.initial() = BadgeCollectionsStateInitial;
  factory BadgeCollectionsState.fetched({
    required List<BadgeList> collections,
    required List<BadgeList> selectedCollections,
  }) = BadgeCollectionsStateFetched;
  factory BadgeCollectionsState.failure() = BadgeCollectionsStateFailure;
}
