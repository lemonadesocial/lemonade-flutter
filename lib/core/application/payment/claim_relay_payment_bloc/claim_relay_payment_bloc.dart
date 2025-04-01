import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/lemonade_relay/lemonade_relay_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_relay_payment_bloc.freezed.dart';

class ClaimRelayPaymentBloc
    extends Bloc<ClaimRelayPaymentEvent, ClaimRelayPaymentState> {
  ClaimRelayPaymentBloc() : super(ClaimRelayPaymentState.idle()) {
    on<_ClaimRelayPaymentEventClaim>(_claim);
    on<_ClaimRelayPaymentEventReset>(_reset);
  }

  Future<void> _claim(_ClaimRelayPaymentEventClaim event, Emitter emit) async {
    emit(
      ClaimRelayPaymentState.waiting(
        chain: event.chain,
      ),
    );
    final result = await LemonadeRelayUtils.claimSplit(
      paymentSplitterContractAddress: event.paymentSplitterContractAddress,
      connectedWalletAddress:
          // getIt<WalletConnectService>().w3mService.session?.address ?? '',
          // TODO: FIX WALLET MIGRATION
          '',
      chain: event.chain,
      tokens: event.tokens,
    );
    result.fold(
      (l) {
        emit(
          ClaimRelayPaymentState.failure(
            failure: l,
            chain: event.chain,
          ),
        );
      },
      (r) {
        emit(
          ClaimRelayPaymentState.success(
            chain: event.chain,
            txHash: r,
          ),
        );
      },
    );
  }

  _reset(_ClaimRelayPaymentEventReset event, Emitter emit) {
    emit(ClaimRelayPaymentState.idle());
  }
}

@freezed
class ClaimRelayPaymentEvent with _$ClaimRelayPaymentEvent {
  factory ClaimRelayPaymentEvent.claim({
    required Chain chain,
    required List<ERC20Token> tokens,
    required String paymentSplitterContractAddress,
    required String connectedWalletAddress,
  }) = _ClaimRelayPaymentEventClaim;
  factory ClaimRelayPaymentEvent.reset() = _ClaimRelayPaymentEventReset;
}

@freezed
class ClaimRelayPaymentState with _$ClaimRelayPaymentState {
  factory ClaimRelayPaymentState.idle() = _ClaimRelayPaymentStateIdle;
  factory ClaimRelayPaymentState.waiting({
    required Chain chain,
    String? txHash,
  }) = _ClaimRelayPaymentStateWaiting;
  factory ClaimRelayPaymentState.success({
    required Chain chain,
    String? txHash,
  }) = _ClaimRelayPaymentStateSuccess;
  factory ClaimRelayPaymentState.failure({
    required Chain chain,
    String? txHash,
    Failure? failure,
  }) = _ClaimRelayPaymentStateFailure;
}
