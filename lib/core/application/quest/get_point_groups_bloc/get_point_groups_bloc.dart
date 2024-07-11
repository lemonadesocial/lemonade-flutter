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
          ),
        ) {
    on<_GetPointGroupsEventFetch>(_onFetch);
  }

  void _onFetch(_GetPointGroupsEventFetch event, Emitter emit) async {
    emit(state.copyWith(fetching: true));
    final result = await _questRepository.getPointGroups();
    result.fold((l) {
      emit(
        state.copyWith(fetching: false),
      );
    }, (pointGroups) {
      emit(
        state.copyWith(fetching: false, pointGroups: pointGroups),
      );
    });
  }
}

@freezed
class GetPointGroupsEvent with _$GetPointGroupsEvent {
  factory GetPointGroupsEvent.fetch() = _GetPointGroupsEventFetch;
}

@freezed
class GetPointGroupsState with _$GetPointGroupsState {
  factory GetPointGroupsState({
    required bool fetching,
    required List<PointGroup> pointGroups,
  }) = _GetPointGroupsState;
}
