import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_guest_settings_bloc.freezed.dart';

@lazySingleton
class EventGuestSettingsBloc
    extends Bloc<EventGuestSettingEvent, EventGuestSettingState> {
  EventGuestSettingsBloc() : super(const EventGuestSettingState()) {
    on<RequireApprovalChanged>(_onRequiredApprovalChanged);
    on<GuestLimitChanged>(_onGuestLimitChanged);
    on<GuestLimitPerChanged>(_onGuestLimitPerChanged);
    on<PrivateChanged>(_onPrivateChanged);
  }

  Future<void> _onRequiredApprovalChanged(
    RequireApprovalChanged event,
    Emitter<EventGuestSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        approvalRequired: event.approvalRequired,
      ),
    );
  }

  Future<void> _onGuestLimitChanged(
    GuestLimitChanged event,
    Emitter<EventGuestSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        guestLimit: event.guestLimit,
      ),
    );
  }

  Future<void> _onGuestLimitPerChanged(
    GuestLimitPerChanged event,
    Emitter<EventGuestSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        guestLimitPer: event.guestLimitPer,
      ),
    );
  }

  Future<void> _onPrivateChanged(
    PrivateChanged event,
    Emitter<EventGuestSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        private: event.private,
      ),
    );
  }
}

@freezed
class EventGuestSettingEvent with _$EventGuestSettingEvent {
  const factory EventGuestSettingEvent.guestLimitChanged({
    required String? guestLimit,
  }) = GuestLimitChanged;

  const factory EventGuestSettingEvent.guestLimitPerChanged({
    required String? guestLimitPer,
  }) = GuestLimitPerChanged;

  const factory EventGuestSettingEvent.privateChanged({required bool private}) =
      PrivateChanged;

  const factory EventGuestSettingEvent.requireApprovalChanged({
    required bool approvalRequired,
  }) = RequireApprovalChanged;
}

@freezed
class EventGuestSettingState with _$EventGuestSettingState {
  const factory EventGuestSettingState({
    @Default("100") String? guestLimit,
    @Default("2") String? guestLimitPer,
    @Default(false) bool private,
    @Default(false) bool approvalRequired,
    @Default(true) bool virtual,
    @Default(false) bool isValid,
  }) = _EventGuestSettingState;
}
