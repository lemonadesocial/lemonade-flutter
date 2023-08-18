import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/badge/entities/badge_entities.dart';
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_poap_bloc.freezed.dart';

class ClaimPoapBloc extends Bloc<ClaimPoapEvent, ClaimPoapState> {
  ClaimPoapBloc({
    required this.badge,
  }) : super(const ClaimPoapState()) {
    on<ClaimPoapEventCheckHasClaimed>(_onCheckHasClaimed);
  }
  final Badge badge;
  final _poapRepository = getIt<PoapRepository>();

  Future<void> _onCheckHasClaimed(ClaimPoapEventCheckHasClaimed event, Emitter emit) async {
    final userWallet = getIt<AuthBloc>()
        .state
        .maybeWhen(authenticated: (authSession) => authSession.walletCustodial, orElse: () => null);
    if (userWallet == null) return;
    final result = await _poapRepository.checkHasClaimedPoap(
      input: CheckHasClaimedPoapViewInput(
        network: badge.network ?? '',
        address: badge.contract?.toLowerCase() ?? '',
        args: [
          [
            userWallet.toLowerCase(),
          ],
        ],
      ),
    );
    result.fold(
      (l) => null,
      (poapViewCheckHasClaimed) => emit(
        ClaimPoapState(
          claimed: poapViewCheckHasClaimed.claimed,
        ),
      ),
    );
  }
}

@freezed
class ClaimPoapEvent with _$ClaimPoapEvent {
  const factory ClaimPoapEvent.checkHasClaimed() = ClaimPoapEventCheckHasClaimed;
  const factory ClaimPoapEvent.claim() = ClaimPoapEventClaim;
}

@freezed
class ClaimPoapState with _$ClaimPoapState {
  const factory ClaimPoapState({
    @Default(false) bool claimed,
  }) = _ClaimPoapState;
}
