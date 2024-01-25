import 'package:app/core/domain/event/entities/event_reward_use.dart';
import 'package:app/core/domain/event/repository/event_reward_repository.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_rewards_bloc.freezed.dart';

class ClaimRewardsBloc extends Bloc<ClaimRewardsEvent, ClaimRewardsState> {
  final String? eventId;
  ClaimRewardsBloc(this.eventId) : super(ClaimRewardsState()) {
    on<_ClaimRewardsEventGetUserDetail>(_onGetUserDetail);
    on<_ClaimRewardsEventGetEventRewardUses>(_onGetEventRewardUses);
  }
  final _userRepository = getIt<UserRepository>();
  final _eventRewardRepository = getIt<EventRewardRepository>();

  void _onGetUserDetail(
    _ClaimRewardsEventGetUserDetail event,
    Emitter emit,
  ) async {
    final result = await _userRepository.getUser(
      userId: event.userId ?? '',
    );
    result.fold(
      (failure) => emit(state.copyWith(scannedUserDetail: null)),
      (user) {
        emit(state.copyWith(scannedUserDetail: user));
      },
    );
  }

  void _onGetEventRewardUses(
    _ClaimRewardsEventGetEventRewardUses event,
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
class ClaimRewardsEvent with _$ClaimRewardsEvent {
  factory ClaimRewardsEvent.getUserDetail({
    required String? userId,
  }) = _ClaimRewardsEventGetUserDetail;

  factory ClaimRewardsEvent.getEventRewardUses({
    required String? userId,
    required String? eventId,
    bool? showLoading,
  }) = _ClaimRewardsEventGetEventRewardUses;
}

@freezed
class ClaimRewardsState with _$ClaimRewardsState {
  factory ClaimRewardsState({
    User? scannedUserDetail,
    List<EventRewardUse>? eventRewardUses,
    bool? initialLoading,
  }) = _ClaimRewardsState;
}
