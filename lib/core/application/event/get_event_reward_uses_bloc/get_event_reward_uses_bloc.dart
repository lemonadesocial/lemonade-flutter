import 'package:app/core/domain/event/entities/event_reward_use.dart';
import 'package:app/core/domain/event/repository/event_reward_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_reward_uses_bloc.freezed.dart';

class GetEventRewardUsesBloc
    extends Bloc<GetEventRewardUsesEvent, GetEventRewardUsesState> {
  final String? eventId;
  GetEventRewardUsesBloc(this.eventId) : super(GetEventRewardUsesState()) {
    on<_GetEventRewardUsesEventGetEventRewardUses>(_onGetEventRewardUses);
  }
  final _eventRewardRepository = getIt<EventRewardRepository>();

  void _onGetEventRewardUses(
    _GetEventRewardUsesEventGetEventRewardUses event,
    Emitter emit,
  ) async {
    if (event.showLoading == true) {
      emit(state.copyWith(initialLoading: true));
    }

    final result = await _eventRewardRepository.getEventRewardUses(
      input: Input$GetEventRewardUsesInput(
        event: event.eventId ?? '',
        user: event.userId ?? '',
      ),
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(eventRewardUses: [], initialLoading: false)),
      (eventRewardUses) {
        emit(
          state.copyWith(
            eventRewardUses: eventRewardUses,
            initialLoading: false,
          ),
        );
      },
    );
  }
}

@freezed
class GetEventRewardUsesEvent with _$GetEventRewardUsesEvent {
  factory GetEventRewardUsesEvent.getEventRewardUses({
    required String? userId,
    required String? eventId,
    bool? showLoading,
  }) = _GetEventRewardUsesEventGetEventRewardUses;
}

@freezed
class GetEventRewardUsesState with _$GetEventRewardUsesState {
  factory GetEventRewardUsesState({
    List<EventRewardUse>? eventRewardUses,
    bool? initialLoading,
  }) = _GetEventRewardUsesState;
}
