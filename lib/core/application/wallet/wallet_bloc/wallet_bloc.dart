import 'package:app/core/domain/wallet/wallet_repository.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/reown_appkit.dart';

part 'wallet_bloc.freezed.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final walletRepository = getIt<WalletRepository>();
  final walletConnectService = getIt<WalletConnectService>();

  WalletBloc()
      : super(
          const WalletState(
            state: ConnectButtonState.idle,
          ),
        ) {
    walletConnectService.w3mService.addListener(_updateState);
    on<WalletEventGetActiveSessions>(_onGetActiveSessions);
    on<WalletEventDisconnectWallet>(_onDisconnectWallet);
    on<WalletEventOnStateChange>(_onStateChange);
  }

  @override
  close() async {
    walletConnectService.w3mService.removeListener(_updateState);
    walletConnectService.close();
    super.close();
  }

  _onGetActiveSessions(WalletEventGetActiveSessions event, Emitter emit) async {
    final activeSession = await walletConnectService.getActiveSession();
    emit(state.copyWith(activeSession: activeSession));
  }

  void _onDisconnectWallet(
    WalletEventDisconnectWallet event,
    Emitter emit,
  ) async {
    await walletConnectService.disconnect();
    add(const WalletEvent.getActiveSessions());
  }

  void _onStateChange(WalletEventOnStateChange event, Emitter emit) async {
    final w3mService = walletConnectService.w3mService;
    final isConnected = w3mService.isConnected;
    if (!isConnected) {
      return emit(
        state.copyWith(
          activeSession: w3mService.session,
          state: ConnectButtonState.none,
        ),
      );
    }
    // Case 0: init error
    if (w3mService.status == ReownAppKitModalStatus.error) {
      return emit(
        state.copyWith(
          activeSession: w3mService.session,
          state: ConnectButtonState.error,
        ),
      );
    }
    // Case 1: Is connected
    else if (w3mService.isConnected) {
      return emit(
        state.copyWith(
          activeSession: w3mService.session,
          state: ConnectButtonState.connected,
        ),
      );
    }
    // Case 1.5: No required namespaces
    else if (!w3mService.hasNamespaces) {
      return emit(
        state.copyWith(
          activeSession: w3mService.session,
          state: ConnectButtonState.disabled,
        ),
      );
    }
    // Case 2: Is not open and is not connected
    else if (!w3mService.isOpen && !w3mService.isConnected) {
      return emit(
        state.copyWith(
          activeSession: w3mService.session,
          state: ConnectButtonState.idle,
        ),
      );
    }
    // Case 3: Is open and is not connected
    else if (w3mService.isOpen && !w3mService.isConnected) {
      return emit(
        state.copyWith(
          state: ConnectButtonState.connecting,
        ),
      );
    }
  }

  void _updateState() {
    add(const WalletEvent.onStateChange());
  }
}

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.getActiveSessions() = WalletEventGetActiveSessions;
  const factory WalletEvent.disconnect() = WalletEventDisconnectWallet;
  const factory WalletEvent.onStateChange() = WalletEventOnStateChange;
}

@freezed
class WalletState with _$WalletState {
  const factory WalletState({
    ReownAppKitModalSession? activeSession,
    required ConnectButtonState state,
  }) = _WalletState;
}
