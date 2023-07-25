import 'dart:async';

import 'package:app/core/domain/auth/entities/auth_session.dart';
import 'package:app/core/oauth.dart';
import 'package:app/core/service/auth/auth_service.dart';
import 'package:app/core/service/user/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final UserService userService;
  late StreamSubscription? _tokenStateSubscription;
  AuthBloc({
    required this.userService,
    required this.authService,
  }) : super(const AuthState.unknown()) {
    _tokenStateSubscription = authService.tokenStateStream.listen(_onTokenStateChange);
    on<AuthEventCheckAuthenticated>(_onCheckAuthenticated);
    on<AuthEventLogin>(_onLogin);
    on<AuthEventLogout>(_onLogout);
    on<AuthEventAuthenticated>(_onAuthenticated);
    on<AuthEventUnAuthenticated>(_onUnAuthenticated);
  }

  @override
  Future<void> close() async {
    await _tokenStateSubscription?.cancel();
    super.close();
  }

  _onTokenStateChange(OAuthTokenState tokenState) {
    if (tokenState == OAuthTokenState.valid) {
      add(AuthEvent.authenticated());
    } else {
      add(AuthEvent.unauthenticated());
    }
  }

  _onAuthenticated(AuthEventAuthenticated event, Emitter emit) async {
    emit(const AuthState.processing());
    await Future.delayed(Duration(milliseconds: 500));
    final session = await _createSession();
    if (session != null) {
      emit(AuthState.authenticated(authSession: session));
      return;
    }
    emit(const AuthState.unauthenticated(isChecking: false));
  }

  _onUnAuthenticated(AuthEventUnAuthenticated event, Emitter emit) {
    emit(const AuthState.unauthenticated(isChecking: false));
  }

  _onCheckAuthenticated(AuthEventCheckAuthenticated event, Emitter emit) async {
    await authService.checkAuthenticated();
  }

  _onLogin(AuthEventLogin event, Emitter emit) async {
    await authService.login();
  }

  _onLogout(AuthEventLogout event, Emitter emit) async {
    await authService.logout();
  }

  Future<AuthSession?> _createSession() async {
    final getMeResult = await userService.getMe();
    return getMeResult.fold((l) => null, (authUser) => authService.createSession(authUser));
  }
}

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login() = AuthEventLogin;
  const factory AuthEvent.logout() = AuthEventLogout;
  const factory AuthEvent.checkAuthenticated() = AuthEventCheckAuthenticated;
  const factory AuthEvent.authenticated() = AuthEventAuthenticated;
  const factory AuthEvent.unauthenticated() = AuthEventUnAuthenticated;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = AuthStateUnknown;
  const factory AuthState.processing() = AuthStateProcessing;
  const factory AuthState.unauthenticated({required bool isChecking}) = AuthStateUnauthenticated;
  const factory AuthState.authenticated({
    required AuthSession authSession,
  }) = AuthStateAuthenticated;
}
