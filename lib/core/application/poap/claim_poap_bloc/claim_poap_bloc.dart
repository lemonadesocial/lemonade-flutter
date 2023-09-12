import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/poap/entities/poap_entities.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_enums.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/injection/register_module.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'claim_poap_bloc.freezed.dart';

class ClaimPoapBloc extends Bloc<ClaimPoapEvent, ClaimPoapState> {
  ClaimPoapBloc({
    required this.badge,
  }) : super(const ClaimPoapState()) {
    on<ClaimPoapEventCheckHasClaimed>(_onCheckHasClaimed);
    on<ClaimPoapEventClaim>(
      _onClaim,
      transformer: (events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 300))
            .asyncExpand(mapper);
      },
    );
  }
  final Badge badge;
  final _poapRepository = getIt<PoapRepository>();

  Future<void> _onCheckHasClaimed(
    ClaimPoapEventCheckHasClaimed event,
    Emitter emit,
  ) async {
    final userWallet = getIt<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.walletCustodial,
          orElse: () => null,
        );
    if (userWallet == null) return;

    Either<Failure, PoapPolicy>? poapPolicyData;
    if (badge.claimable != true) {
      poapPolicyData = await _poapRepository.getPoapPolicy(
        input: GetPoapPolicyInput(
          network: badge.network ?? '',
          address: badge.contract?.toLowerCase() ?? '',
          target: userWallet.toLowerCase(),
        ),
      );
    }

    final hasClaimedData = await _poapRepository.checkHasClaimedPoap(
      input: CheckHasClaimedPoapViewInput(
        network: badge.network ?? '',
        address: badge.contract?.toLowerCase() ?? '',
        args: [
          [
            userWallet.toLowerCase(),
          ],
        ],
      ),
      fromServer: event.fromServer,
    );

    final poapPolicy = poapPolicyData?.fold((l) => null, (r) => r);
    final hasClaimed = hasClaimedData.fold((l) => null, (r) => r);
    emit(
      state.copyWith(
        policy: poapPolicy,
        claimed: hasClaimed?.claimed ?? false,
      ),
    );
  }

  Future<void> _onClaim(ClaimPoapEventClaim event, Emitter emit) async {
    emit(
      state.copyWith(claiming: true, failure: null),
    );
    final result = await _poapRepository.claim(input: event.input);
    result.fold(
      (failure) {
        emit(
          state.copyWith(failure: failure),
        );
      },
      (claim) {
        emit(
          state.copyWith(
            claim: claim,
            claiming: false,
            claimed: claim.state != ClaimState.FAILED,
          ),
        );
      },
    );
    emit(state.copyWith(claiming: false));
  }
}

@freezed
class ClaimPoapEvent with _$ClaimPoapEvent {
  const factory ClaimPoapEvent.checkHasClaimed({
    @Default(false) bool fromServer,
  }) = ClaimPoapEventCheckHasClaimed;
  const factory ClaimPoapEvent.claim({
    required ClaimInput input,
  }) = ClaimPoapEventClaim;
  const factory ClaimPoapEvent.getPolicy({
    required GetPoapPolicyInput input,
  }) = ClaimPoapEventGetPoapPolicy;
}

@freezed
class ClaimPoapState with _$ClaimPoapState {
  const factory ClaimPoapState({
    @Default(false) bool claimed,
    @Default(false) bool claiming,
    Claim? claim,
    Failure? failure,
    PoapPolicy? policy,
  }) = _ClaimPoapState;
}
