import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/wallet/wallet_repository.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

part 'wallet_bloc.freezed.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final walletRepository = getIt<WalletRepository>();
  final walletConnectService = getIt<WalletConnectService>();

  WalletBloc() : super(const WalletState()) {
    on<WalletEventInitWalletConnect>(_onInitWalletConnect);
    on<WalletEventGetActiveSessions>(_onGetActiveSessions);
    on<WalletEventConnectWallet>(_onConnectWallet);
    on<WalletEventUpdateUserWallet>(_onUpdateUserWallet);
    on<WalletEventDisconnectWallet>(_onDisconnectWallet);
  }

  @override
  close() async {
    walletConnectService.close();
    super.close();
  }

  _onInitWalletConnect(WalletEventInitWalletConnect event, Emitter emit) async {
    final success = await walletConnectService.init();
    if (success) {
      add(const WalletEventGetActiveSessions());
    }
  }

  _onGetActiveSessions(WalletEventGetActiveSessions event, Emitter emit) async {
    final activeSession = await walletConnectService.getActiveSession();
    emit(state.copyWith(activeSession: activeSession));
  }

  _onConnectWallet(WalletEventConnectWallet event, Emitter emit) async {
    var success =
        await walletConnectService.connectWallet(walletApp: event.walletApp);
    if (success) {
      add(const WalletEvent.getActiveSessions());
    }
  }

  _onDisconnectWallet(WalletEventDisconnectWallet event, Emitter emit) async {
    await walletConnectService.disconnect();
    add(const WalletEvent.getActiveSessions());
  }

  _onUpdateUserWallet(WalletEventUpdateUserWallet event, Emitter emit) async {
    final walletRequestResult = await walletRepository.getUserWalletRequest(
      wallet: event.wallet.toLowerCase(),
    );

    if (walletRequestResult.isLeft()) {
      return SnackBarUtils.showErrorSnackbar("Sign wallet failed");
    }

    final userWalletRequest = walletRequestResult.getOrElse(() => null);
    if (userWalletRequest == null) {
      return SnackBarUtils.showErrorSnackbar("Sign wallet failed");
    }

    String signedMessage = Web3Utils.toHex(userWalletRequest.message);

    final signature = await walletConnectService.personalSign(
      message: signedMessage,
      wallet: event.wallet,
      walletApp: SupportedWalletApp.metamask,
    );

    if (signature == null) {
      return SnackBarUtils.showErrorSnackbar("Sign wallet failed");
    }

    final result = await walletRepository.setUserWallet(
      token: userWalletRequest.token,
      signature: signature,
    );

    result.fold(
      (l) {
        SnackBarUtils.showErrorSnackbar("Sign wallet failed");
      },
      (isSuccess) {
        if (isSuccess) {
          SnackBarUtils.showSuccessSnackbar("Wallet successfully signed");
        } else {
          SnackBarUtils.showErrorSnackbar("Sign wallet failed");
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
    required SupportedWalletApp walletApp,
  }) = WalletEventUpdateUserWallet;
  const factory WalletEvent.disconnect() = WalletEventDisconnectWallet;
}

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    SessionData? activeSession,
  }) = _WalletState;
}
