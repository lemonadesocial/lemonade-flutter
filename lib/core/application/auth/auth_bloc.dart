import 'dart:async';

import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/managers/crash_analytics_manager.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/core/utils/onboarding_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final firebaseService = getIt<FirebaseService>();
  final userRepository = getIt<UserRepository>();
  final appOauth = getIt<AppOauth>();
  late StreamSubscription? _tokenStateSubscription;

  AuthBloc() : super(const AuthState.unknown()) {
    _tokenStateSubscription =
        appOauth.tokenStateStream.listen(_onTokenStateChange);
    on<AuthEventLogin>(_onLogin);
    on<AuthEventLogout>(_onLogout);
    on<AuthEventForceLogout>(_onForceLogout);
    on<AuthEventAuthenticated>(_onAuthenticated);
    on<AuthEventUnAuthenticated>(_onUnAuthenticated);
    on<AuthEventRefresh>(_onRefresh);
  }

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
    final currentUser = await _createSession();
    if (currentUser != null) {
      if (OnboardingUtils.isOnboardingRequired(currentUser)) {
        emit(AuthState.onBoardingRequired(authSession: currentUser));
        return;
      }
      if (!kDebugMode) {
        await FirebaseAnalytics.instance.setUserId(id: currentUser.userId);
      }
      emit(AuthState.authenticated(authSession: currentUser));
      return;
    }
    // This will trigger token state listener to call _onUnAuthenticated
    await appOauth.forceLogout();
  }

  void _onUnAuthenticated(AuthEventUnAuthenticated event, Emitter emit) {
    emit(const AuthState.unauthenticated(isChecking: false));
  }

  Future<void> _onRefresh(AuthEventRefresh event, Emitter emit) async {
    if (state is! AuthStateAuthenticated) {
      emit(const AuthState.processing());
    }
    final currentUser = await _createSession();
    if (!kDebugMode) {
      await FirebaseAnalytics.instance.setUserId(id: currentUser?.userId);
    }
    emit(AuthState.authenticated(authSession: currentUser!));
  }

  Future<void> _onLogin(AuthEventLogin event, Emitter emit) async {
    await appOauth.login();
  }

  Future<void> _onLogout(AuthEventLogout event, Emitter emit) async {
    await firebaseService.removeFcmToken();
    // This will trigger token state listener to call _onUnAuthenticated
    final result = await appOauth.logout();
    result.fold((l) => null, (success) async {
      if (success) {
        if (!kDebugMode) {
          FirebaseAnalytics.instance.setUserId(id: null);
        }
        CrashAnalyticsManager().crashAnalyticsService?.clearSetUser();
      }
    });
  }

  Future<void> _onForceLogout(AuthEventForceLogout event, Emitter emit) async {
    // This will trigger token state listener to call _onUnAuthenticated
    if (!kDebugMode) {
      FirebaseAnalytics.instance.setUserId(id: null);
    }
    CrashAnalyticsManager().crashAnalyticsService?.clearSetUser();
    await firebaseService.removeFcmToken();
    await appOauth.forceLogout();
  }

  Future<User?> _createSession() async {
    final result = await userRepository.getMe();
    return result.fold((l) => null, (user) => user);
  }
}

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login() = AuthEventLogin;

  const factory AuthEvent.logout() = AuthEventLogout;

  const factory AuthEvent.forceLogout() = AuthEventForceLogout;

  const factory AuthEvent.refreshData() = AuthEventRefresh;

  const factory AuthEvent.authenticated() = AuthEventAuthenticated;

  const factory AuthEvent.unauthenticated() = AuthEventUnAuthenticated;
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
