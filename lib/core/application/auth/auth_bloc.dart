import 'package:app/core/service/auth/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc({required this.authService}) : super(const AuthState.unknown()) {
    on<AuthEventCheckAuthenticated>(_onCheckAuthenticated);
    on<AuthEventLogin>(_onLogin);
    on<AuthEventLogout>(_onLogout);
  }

  _onCheckAuthenticated(AuthEventCheckAuthenticated event, Emitter emit) async {
    var isAuthenticated = await authService.checkAuthenticated();
    emit(
      isAuthenticated ? const AuthState.authenticated() : const AuthState.unauthenticated(isChecking: false),
    );
  }

  _onLogin(AuthEventLogin event, Emitter emit) async {
    emit(const AuthState.unauthenticated(isChecking: true));
    var result = await authService.login();
    result.fold((failure) {
      emit(const AuthState.unauthenticated(isChecking: false));
    }, (success) {
      emit(const AuthState.authenticated());
    });
  }

  _onLogout(AuthEventLogout event, Emitter emit) async {
    final result = await authService.logout();
    if (result.isRight()) emit(const AuthState.unauthenticated(isChecking: false));
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
  const factory AuthState.authenticated() = AuthStateAuthenticated;
}
