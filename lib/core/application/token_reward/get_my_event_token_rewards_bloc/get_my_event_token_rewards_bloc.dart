import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/reward/entities/reward_signature_response.dart';
import 'package:app/core/domain/reward/reward_repository.dart';
import 'package:app/graphql/backend/event/query/get_my_tickets.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_my_event_token_rewards_bloc.freezed.dart';

@freezed
class GetMyEventTokenRewardsEvent with _$GetMyEventTokenRewardsEvent {
  const factory GetMyEventTokenRewardsEvent.fetch({
    required String eventId,
  }) = _Fetch;
}

@freezed
class GetMyEventTokenRewardsState with _$GetMyEventTokenRewardsState {
  const factory GetMyEventTokenRewardsState.initial() = _Initial;
  const factory GetMyEventTokenRewardsState.loading() = _Loading;
  const factory GetMyEventTokenRewardsState.success(
    List<RewardSignatureResponse> rewards,
  ) = _Success;
  const factory GetMyEventTokenRewardsState.failure(String message) = _Failure;
}

class GetMyEventTokenRewardsBloc
    extends Bloc<GetMyEventTokenRewardsEvent, GetMyEventTokenRewardsState> {
  GetMyEventTokenRewardsBloc()
      : super(const GetMyEventTokenRewardsState.initial()) {
    on<GetMyEventTokenRewardsEvent>((event, emit) async {
      await event.map(
        fetch: (e) async => await _onFetch(e, emit),
      );
    });
  }

  Future<void> _onFetch(
    _Fetch event,
    Emitter<GetMyEventTokenRewardsState> emit,
  ) async {
    emit(const GetMyEventTokenRewardsState.loading());

    try {
      final payments = (await getIt<EventTicketRepository>().getMyTickets(
            input: Variables$Query$GetMyTickets(
              event: event.eventId,
              withPaymentInfo: true,
            ),
          ))
              .fold(
                (l) => null,
                (r) => r,
              )
              ?.payments ??
          [];

      final response = await Future.wait([
        getIt<RewardRepository>().generateClaimTicketRewardSignature(
          event: event.eventId,
          payment: null,
        ),
        ...payments.map(
          (p) => getIt<RewardRepository>().generateClaimTicketRewardSignature(
            event: event.eventId,
            payment: p.id ?? '',
          ),
        ),
      ]);

      final signatureResponses = response
          .map((r) => r.fold((l) => null, (r) => r))
          .whereType<RewardSignatureResponse>()
          .toList();

      emit(GetMyEventTokenRewardsState.success(signatureResponses));
    } catch (e) {
      emit(GetMyEventTokenRewardsState.failure(e.toString()));
    }
  }
}
