import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/service/wallet/wallet_service.dart';
import 'package:app/core/service/wallet_connect/wallet_connect_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

part 'wallet_bloc.freezed.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletService walletService = WalletService();

  WalletBloc() : super(const WalletState()) {
    on<WalletEventInitWalletConnect>(_onInitWalletConnect);
    on<WalletEventGetActiveSessions>(_onGetActiveSessions);
    on<WalletEventConnectWallet>(_onConnectWallet);
    on<WalletEventUpdateUserWallet>(_onUpdateUserWallet);
  }

  @override
  close() async {
    walletService.close();
    super.close();
  }

  _onInitWalletConnect(WalletEventInitWalletConnect event, Emitter emit) async {
    final result = await walletService.initWallet();
    if (result.isRight()) {
      add(const WalletEventGetActiveSessions());
    }
  }

  _onGetActiveSessions(WalletEventGetActiveSessions event, Emitter emit) async {
    final activeSession = await walletService.getActiveSession();
    if (activeSession != null) {
      emit(state.copyWith(activeSession: activeSession));
    }
  }

  _onConnectWallet(WalletEventConnectWallet event, Emitter emit) async {
    var result = await walletService.connectWallet(walletApp: event.walletApp);
    if (result.isRight()) {
      add(const WalletEvent.getActiveSessions());
    }
  }

  _onUpdateUserWallet(WalletEventUpdateUserWallet event, Emitter emit) async {
    final result = await walletService.updateUserWallet(wallet: event.wallet);
    result.fold(
      (l) {
        SnackBarUtils.showSnackbar("Sign wallet failed");
      },
      (isSuccess) {
        if (isSuccess) {
          SnackBarUtils.showSnackbar("Wallet successfully signed");
        } else {
          SnackBarUtils.showSnackbar("Sign wallet failed");
        }
      },
    );
  }
}

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.initWalletConnect() = WalletEventInitWalletConnect;
  const factory WalletEvent.connectWallet({
    required SupportedWalletApp walletApp,
    List<Chains>? chains,
  }) = WalletEventConnectWallet;
  const factory WalletEvent.getActiveSessions() = WalletEventGetActiveSessions;
  const factory WalletEvent.updateUserWallet({
    required String wallet,
  }) = WalletEventUpdateUserWallet;
}

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    SessionData? activeSession,
  }) = _WalletState;
}
