import 'package:app/core/domain/quest/entities/point_group.dart';
import 'package:app/core/domain/quest/quest_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_point_groups_bloc.freezed.dart';

class GetPointGroupsBloc
    extends Bloc<GetPointGroupsEvent, GetPointGroupsState> {
  final _questRepository = getIt<QuestRepository>();
  GetPointGroupsBloc()
      : super(
          GetPointGroupsState(
            fetching: true,
            pointGroups: [],
            selectedFirstLevelGroup: null,
            selectedSecondLevelGroup: null,
          ),
        ) {
    on<_GetPointGroupsEventFetch>(_onFetch);
    on<_GetPointGroupsEventSelectFirstLevelGroup>(_onSelectFirstLevelGroup);
    on<_GetPointGroupsEventSelectSecondLevelGroup>(_onSelectSecondLevelGroup);
  }

  void _onFetch(_GetPointGroupsEventFetch event, Emitter emit) async {
    emit(state.copyWith(fetching: true));
    final result = await _questRepository.getPointGroups();
    result.fold((l) {
      emit(
        state.copyWith(fetching: false),
      );
    }, (pointGroups) {
      if (pointGroups.isNotEmpty && state.selectedFirstLevelGroup == null) {
        emit(
          state.copyWith(
            fetching: false,
            pointGroups: pointGroups,
            selectedFirstLevelGroup: pointGroups.first.firstLevelGroup?.id,
          ),
        );
      } else {
        emit(
          state.copyWith(fetching: false, pointGroups: pointGroups),
        );
      }
    });
  }

  void _onSelectFirstLevelGroup(
    _GetPointGroupsEventSelectFirstLevelGroup event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        selectedFirstLevelGroup: event.firstLevelGroup,
        selectedSecondLevelGroup: null,
      ),
    );
  }

  void _onSelectSecondLevelGroup(
    _GetPointGroupsEventSelectSecondLevelGroup event,
    Emitter emit,
  ) async {
    // Uncheck when tap again
    if (event.secondLevelGroup == state.selectedSecondLevelGroup) {
      emit(
        state.copyWith(
          selectedSecondLevelGroup: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedSecondLevelGroup: event.secondLevelGroup,
        ),
      );
    }
  }
}

@freezed
class GetPointGroupsEvent with _$GetPointGroupsEvent {
  factory GetPointGroupsEvent.fetch() = _GetPointGroupsEventFetch;

  factory GetPointGroupsEvent.selectFirstLevelGroup({
    required String? firstLevelGroup,
  }) = _GetPointGroupsEventSelectFirstLevelGroup;

  factory GetPointGroupsEvent.selectSecondLevelGroup({
    required String? secondLevelGroup,
  }) = _GetPointGroupsEventSelectSecondLevelGroup;
}

@freezed
class GetPointGroupsState with _$GetPointGroupsState {
  factory GetPointGroupsState({
    required bool fetching,
    required List<PointGroup> pointGroups,
    required String? selectedFirstLevelGroup,
    required String? selectedSecondLevelGroup,
  }) = _GetPointGroupsState;
}
