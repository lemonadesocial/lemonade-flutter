import 'dart:async';

import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/auth/auth_service.dart';
import 'package:app/core/service/user/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.userService,
    required this.authService,
  }) : super(const AuthState.unknown()) {
    _tokenStateSubscription =
        authService.tokenStateStream.listen(_onTokenStateChange);
    on<AuthEventLogin>(_onLogin);
    on<AuthEventLogout>(_onLogout);
    on<AuthEventAuthenticated>(_onAuthenticated);
    on<AuthEventUnAuthenticated>(_onUnAuthenticated);
    on<AuthEventRefresh>(_onRefresh);
    on<AuthEventDelete>(_onDeleteAccount);
  }

  final AuthService authService;
  final UserService userService;
  late StreamSubscription? _tokenStateSubscription;

  @override
  Future<void> close() async {
    await _tokenStateSubscription?.cancel();
    super.close();
  }

  void _onTokenStateChange(OAuthTokenState tokenState) {
    if (tokenState == OAuthTokenState.valid) {
      add(const AuthEvent.authenticated());
    } else {
      add(const AuthEvent.unauthenticated());
    }
  }

  Future<void> _onAuthenticated(
    AuthEventAuthenticated event,
    Emitter emit,
  ) async {
    emit(const AuthState.processing());
    await Future.delayed(const Duration(milliseconds: 500));
    final currentUser = await _createSession();
    if (currentUser != null) {
      if (currentUser.username?.isEmpty ?? true) {
        // Authenticated but lacking username
        // Navigate to OnBoarding flow instead
        emit(AuthState.onBoardingRequired(authSession: currentUser));
        return;
      }
      emit(AuthState.authenticated(authSession: currentUser));
      return;
    }
    emit(const AuthState.unauthenticated(isChecking: false));
  }

  Future<void> _onRefresh(AuthEventRefresh event, Emitter emit) async {
    emit(const AuthState.processing());
    final currentUser = await _createSession();
    emit(AuthState.authenticated(authSession: currentUser!));
  }

  void _onUnAuthenticated(AuthEventUnAuthenticated event, Emitter emit) {
    emit(const AuthState.unauthenticated(isChecking: false));
  }

  Future<void> _onLogin(AuthEventLogin event, Emitter emit) async {
    await authService.login();
  }

  Future<void> _onLogout(AuthEventLogout event, Emitter emit) async {
    await authService.logout();
  }

  Future<void> _onDeleteAccount(AuthEventDelete event, Emitter emit) async {
    emit(const AuthState.processing());
    await authService.deleteAccount().whenComplete(
          () => emit(
            const AuthState.unauthenticated(isChecking: true),
          ),
        );
  }

  Future<User?> _createSession() async {
    final getMeResult = await userService.getMe();
    return getMeResult.fold((l) => null, (user) => user);
  }
}

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login() = AuthEventLogin;

  const factory AuthEvent.logout() = AuthEventLogout;

  const factory AuthEvent.refreshData() = AuthEventRefresh;

  const factory AuthEvent.authenticated() = AuthEventAuthenticated;

  const factory AuthEvent.unauthenticated() = AuthEventUnAuthenticated;

  const factory AuthEvent.deleteAccount() = AuthEventDelete;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = AuthStateUnknown;

  const factory AuthState.processing() = AuthStateProcessing;

  const factory AuthState.unauthenticated({required bool isChecking}) =
      AuthStateUnauthenticated;

  const factory AuthState.onBoardingRequired({
    required User authSession,
  }) = AuthStateOnBoardingRequired;

  const factory AuthState.authenticated({
    required User authSession,
  }) = AuthStateAuthenticated;
}
