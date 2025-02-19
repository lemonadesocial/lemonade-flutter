import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/reward_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_ticket_token_rewards_bloc.freezed.dart';

class ListTicketTokenRewardsBloc
    extends Bloc<ListTicketTokenRewardsEvent, ListTicketTokenRewardsState> {
  ListTicketTokenRewardsBloc()
      : super(const ListTicketTokenRewardsState.initial()) {
    on<_Fetch>(_onFetch);
  }

  Future<void> _onFetch(
    _Fetch event,
    Emitter<ListTicketTokenRewardsState> emit,
  ) async {
    emit(const ListTicketTokenRewardsState.loading());

    final result =
        await getIt<RewardRepository>().listTicketTokenRewardSettings(
      ticketTypes: event.tickets,
      event: event.eventId,
    );

    result.fold(
      (failure) => emit(ListTicketTokenRewardsState.failure(failure)),
      (rewards) => emit(ListTicketTokenRewardsState.success(rewards)),
    );
  }
}

@freezed
class ListTicketTokenRewardsState with _$ListTicketTokenRewardsState {
  const factory ListTicketTokenRewardsState.initial() = _Initial;
  const factory ListTicketTokenRewardsState.loading() = _Loading;
  const factory ListTicketTokenRewardsState.success(
    List<TokenRewardSetting> rewards,
  ) = _Success;
  const factory ListTicketTokenRewardsState.failure(Failure failure) = _Failure;
}

@freezed
class ListTicketTokenRewardsEvent with _$ListTicketTokenRewardsEvent {
  const factory ListTicketTokenRewardsEvent.fetch({
    required String eventId,
    required List<String> tickets,
  }) = _Fetch;
}
