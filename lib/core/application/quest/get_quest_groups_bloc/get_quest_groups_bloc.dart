import 'package:app/graphql/backend/quest/fragment/point_group_fragment.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_quest_groups_bloc.freezed.dart';

class GetPointGroupsBloc
    extends Bloc<GetPointGroupsEvent, GetPointGroupsState> {
  GetPointGroupsBloc()
      : super(
          GetPointGroupsState(
            fetching: true,
            pointGroups: [],
          ),
        ) {
    on<_GetPointGroupsEventFetch>(_onFetch);
  }

  void _onFetch(_GetPointGroupsEventFetch event, Emitter emit) async {}
}

@freezed
class GetPointGroupsEvent with _$GetPointGroupsEvent {
  factory GetPointGroupsEvent.fetch() = _GetPointGroupsEventFetch;
}

@freezed
class GetPointGroupsState with _$GetPointGroupsState {
  factory GetPointGroupsState({
    required bool fetching,
    required List<Fragment$PointGroup> pointGroups,
  }) = _GetPointGroupsState;
}
