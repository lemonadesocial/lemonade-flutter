import 'package:app/core/domain/auth/entities/auth_session.dart';
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
  AuthBloc({required this.authService, required this.userService}) : super(const AuthState.unknown()) {
    on<AuthEventCheckAuthenticated>(_onCheckAuthenticated);
    on<AuthEventLogin>(_onLogin);
    on<AuthEventLogout>(_onLogout);
  }

  _onCheckAuthenticated(AuthEventCheckAuthenticated event, Emitter emit) async {
    var isAuthenticated = await authService.checkAuthenticated();
    if (isAuthenticated) {
      final session = await _createSession();
      if (session != null) {
        emit(AuthState.authenticated(authSession: session));
        return;
      }
      emit(const AuthState.unauthenticated(isChecking: false));
      return;
    }
    emit(const AuthState.unauthenticated(isChecking: false));
  }

  _onLogin(AuthEventLogin event, Emitter emit) async {
    emit(const AuthState.unauthenticated(isChecking: true));
    var result = await authService.login();
    if (result.isRight()) {
      final session = await _createSession();
      if (session != null) {
        emit(AuthState.authenticated(authSession: session));
        return;
      }
      emit(const AuthState.unauthenticated(isChecking: false));
    }
    emit(const AuthState.unauthenticated(isChecking: false));
  }

  _onLogout(AuthEventLogout event, Emitter emit) async {
    await authService.logout();
    emit(const AuthState.unauthenticated(isChecking: false));
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
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = AuthStateUnknown;
  const factory AuthState.unauthenticated({required bool isChecking}) = AuthStateUnauthenticated;
  const factory AuthState.authenticated({
    required AuthSession authSession,
  }) = AuthStateAuthenticated;
}
