import 'dart:async';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/managers/crash_analytics_manager.dart';
import 'package:app/core/service/auth_method_tracker/auth_method_tracker.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/core/service/ory_auth/ory_auth.dart';
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
  final oryAuth = getIt<OryAuth>();
  final authMethodTracker = getIt<AuthMethodTracker>();
  late StreamSubscription? _orySessionStateSubscription;

  AuthBloc() : super(const AuthState.unknown()) {
    _orySessionStateSubscription =
        oryAuth.orySessionStateStream.listen(_onOrySessionStateChange);
    on<AuthEventLogout>(_onLogout);
    on<AuthEventForceLogout>(_onForceLogout);
    on<AuthEventAuthenticated>(_onAuthenticated);
    on<AuthEventUnAuthenticated>(_onUnAuthenticated);
    on<AuthEventRefresh>(_onRefresh);
  }

  @override
  Future<void> close() async {
    await _orySessionStateSubscription?.cancel();
    super.close();
  }

  void _onOrySessionStateChange(OrySessionState sessionState) async {
    if (sessionState == OrySessionState.valid) {
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
    final currentUser = await _getMe();
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
    await oryAuth.forceLogout();
  }

  Future<void> _onUnAuthenticated(
    AuthEventUnAuthenticated event,
    Emitter emit,
  ) async {
    emit(const AuthState.unauthenticated(isChecking: false));
  }

  Future<void> _onRefresh(AuthEventRefresh event, Emitter emit) async {
    if (state is! AuthStateAuthenticated) {
      emit(const AuthState.processing());
    }
    final currentUser = await _getMe();
    if (!kDebugMode) {
      await FirebaseAnalytics.instance.setUserId(id: currentUser?.userId);
    }
    emit(AuthState.authenticated(authSession: currentUser!));
  }

  Future<void> _onLogout(AuthEventLogout event, Emitter emit) async {
    await firebaseService.removeFcmToken();
    await oryAuth.logout();
    if (!kDebugMode) {
      FirebaseAnalytics.instance.setUserId(id: null);
    }
    CrashAnalyticsManager().crashAnalyticsService?.clearSetUser();
  }

  Future<void> _onForceLogout(AuthEventForceLogout event, Emitter emit) async {
    // This will trigger token state listener to call _onUnAuthenticated
    if (!kDebugMode) {
      FirebaseAnalytics.instance.setUserId(id: null);
    }
    CrashAnalyticsManager().crashAnalyticsService?.clearSetUser();
    await firebaseService.removeFcmToken();
    await oryAuth.forceLogout();
  }

  Future<User?> _getMe() async {
    final result = await userRepository.getMe();
    return result.fold((l) => null, (user) => user);
  }
}

@freezed
class AuthEvent with _$AuthEvent {
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
