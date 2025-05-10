import 'dart:async';

import 'package:app/core/application/lens/enums.dart';
import 'package:app/core/domain/lens/entities/lens_account.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/service/lens/lens_storage_service/lens_storage_service.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/graphql/lens/auth/query/accounts_available.graphql.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lens_auth_bloc.freezed.dart';

@freezed
class LensAuthState with _$LensAuthState {
  const factory LensAuthState({
    required List<LensAccount> availableAccounts,
    required LensAccountStatus accountStatus,
    required bool connected,
    required bool loggedIn,
    required bool isFetching,
  }) = _LensAuthState;

  factory LensAuthState.initial() => const LensAuthState(
        availableAccounts: [],
        accountStatus: LensAccountStatus.onboarding,
        connected: false,
        loggedIn: false,
        isFetching: false,
      );
}

@freezed
sealed class LensAuthEvent with _$LensAuthEvent {
  const factory LensAuthEvent.init() = _Init;
  const factory LensAuthEvent.unauthorized() = _Unauthorized;
  const factory LensAuthEvent.authorized({
    required String token,
    required String refreshToken,
    String? idToken,
  }) = _Authorized;
  const factory LensAuthEvent.accountCreated({
    required String token,
    required String refreshToken,
    required LensAccount account,
  }) = _AccountCreated;
  const factory LensAuthEvent.requestAvailableAccount({
    required String walletAddress,
  }) = _RequestAvailableAccount;
  const factory LensAuthEvent.walletConnectionChanged() =
      _WalletConnectionChanged;
  const factory LensAuthEvent.tokenStateChange(LensTokenState tokenState) =
      _TokenStateChange;
}

class LensAuthBloc extends Bloc<LensAuthEvent, LensAuthState> {
  final WalletConnectService _walletConnectService;
  final LensStorageService _lensStorageService;
  final LensRepository _lensRepository;
  StreamSubscription? _tokenStateSubscription;

  LensAuthBloc(
    this._lensRepository,
    this._lensStorageService,
    this._walletConnectService,
  ) : super(LensAuthState.initial()) {
    on<_Init>(_onInit);
    on<_RequestAvailableAccount>(_onRequestAvailableAccount);
    on<_Authorized>(_onAuthorized);
    on<_AccountCreated>(_onAccountCreated);
    on<_Unauthorized>(_onUnauthorized);
    on<_WalletConnectionChanged>(_onWalletConnectionChanged);
    on<_TokenStateChange>(_onTokenStateChange);

    _walletConnectService.w3mService?.addListener(_handleConnectionChange);
    _tokenStateSubscription =
        _lensStorageService.tokenStateStream.listen(_handleTokenStateChange);
  }

  Future<void> _onInit(_Init event, Emitter<LensAuthState> emit) async {
    final activeSession = await _walletConnectService.getActiveSession();
    if (activeSession != null) {
      final hasLoggedIn = await _lensStorageService.hasLoggedIn();
      emit(
        state.copyWith(
          connected: true,
          loggedIn: hasLoggedIn,
        ),
      );
      add(
        LensAuthEvent.requestAvailableAccount(
          walletAddress: activeSession.address!,
        ),
      );
    } else {
      add(const LensAuthEvent.unauthorized());
    }
  }

  void _handleConnectionChange() {
    add(const LensAuthEvent.walletConnectionChanged());
  }

  Future<void> _onWalletConnectionChanged(
    LensAuthEvent event,
    Emitter<LensAuthState> emit,
  ) async {
    final w3mService = _walletConnectService.w3mService;
    if (w3mService == null) {
      return;
    }

    if (!w3mService.isConnected) {
      add(const LensAuthEvent.unauthorized());
      return;
    }

    if (w3mService.isConnected && !state.connected) {
      // Wallet connected
      emit(
        state.copyWith(
          connected: true,
        ),
      );
      final activeSession = await _walletConnectService.getActiveSession();
      final address = activeSession?.address;
      if (address != null) {
        add(LensAuthEvent.requestAvailableAccount(walletAddress: address));
      } else {
        add(const LensAuthEvent.unauthorized());
      }
    }
  }

  void _handleTokenStateChange(LensTokenState tokenState) {
    add(LensAuthEvent.tokenStateChange(tokenState));
  }

  Future<void> _onTokenStateChange(
    _TokenStateChange event,
    Emitter<LensAuthState> emit,
  ) async {
    if (event.tokenState == LensTokenState.valid) {
      emit(state.copyWith(loggedIn: true));
    } else if (event.tokenState == LensTokenState.invalid) {
      emit(state.copyWith(loggedIn: false));
    }
  }

  Future<void> _onRequestAvailableAccount(
    _RequestAvailableAccount event,
    Emitter<LensAuthState> emit,
  ) async {
    emit(state.copyWith(isFetching: true));
    final response = await _lensRepository.getAvailableAccounts(
      input: Variables$Query$LensAccountsAvailable(
        accountsAvailableRequest2: Input$AccountsAvailableRequest(
          managedBy: event.walletAddress,
          includeOwned: true,
        ),
      ),
    );

    final availableAccounts = response.fold(
      (l) => <LensAccount>[],
      (r) => r,
    );

    if (availableAccounts.isNotEmpty) {
      emit(
        state.copyWith(
          availableAccounts: availableAccounts,
          accountStatus: LensAccountStatus.accountOwner,
          isFetching: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          availableAccounts: [],
          accountStatus: LensAccountStatus.onboarding,
          isFetching: false,
        ),
      );
    }
  }

  Future<void> _onAuthorized(
    _Authorized event,
    Emitter<LensAuthState> emit,
  ) async {
    try {
      await _lensStorageService.saveTokens(
        accessToken: event.token,
        refreshToken: event.refreshToken,
        idToken: event.idToken,
      );
      emit(state.copyWith(loggedIn: true));
    } catch (e) {
      emit(state.copyWith(loggedIn: false));
    }
  }

  Future<void> _onAccountCreated(
    _AccountCreated event,
    Emitter<LensAuthState> emit,
  ) async {
    await _lensStorageService.saveTokens(
      accessToken: event.token,
      refreshToken: event.refreshToken,
    );

    final response = await _lensRepository.getAvailableAccounts(
      input: Variables$Query$LensAccountsAvailable(
        accountsAvailableRequest2: Input$AccountsAvailableRequest(
          managedBy: event.account.owner ?? '',
          includeOwned: true,
        ),
      ),
    );

    final availableAccounts = response.fold(
      (l) => <LensAccount>[],
      (r) => r,
    );

    emit(
      state.copyWith(
        loggedIn: true,
        availableAccounts: availableAccounts,
        accountStatus: LensAccountStatus.accountOwner,
      ),
    );
  }

  Future<void> _onUnauthorized(
    _Unauthorized event,
    Emitter<LensAuthState> emit,
  ) async {
    emit(
      state.copyWith(
        loggedIn: false,
        connected: false,
        availableAccounts: [],
        isFetching: false,
      ),
    );
    await _lensStorageService.clearTokens();
  }

  @override
  Future<void> close() {
    _tokenStateSubscription?.cancel();
    return super.close();
  }
}
