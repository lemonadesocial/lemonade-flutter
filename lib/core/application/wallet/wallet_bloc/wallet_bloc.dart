import 'package:app/core/domain/wallet/wallet_repository.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
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
    var success = await walletConnectService.connectWallet(
      walletApp: event.walletApp,
      chainId: event.chainId,
    );
    if (success) {
      add(const WalletEvent.getActiveSessions());
    }
  }

  _onDisconnectWallet(WalletEventDisconnectWallet event, Emitter emit) async {
    await walletConnectService.disconnect();
    add(const WalletEvent.getActiveSessions());
  }
}

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.initWalletConnect() = WalletEventInitWalletConnect;
  const factory WalletEvent.connectWallet({
    required SupportedWalletApp walletApp,
    String? chainId,
  }) = WalletEventConnectWallet;
  const factory WalletEvent.getActiveSessions() = WalletEventGetActiveSessions;
  const factory WalletEvent.disconnect() = WalletEventDisconnectWallet;
}

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    SessionData? activeSession,
  }) = _WalletState;
}
