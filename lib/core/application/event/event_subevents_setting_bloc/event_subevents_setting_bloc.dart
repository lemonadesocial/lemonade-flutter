import 'package:app/core/domain/event/entities/sub_event_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_subevents_setting_bloc.freezed.dart';

@lazySingleton
class EventSubEventsSettingBloc
    extends Bloc<EventGuestSettingEvent, EventSubEventsSettingState> {
  EventSubEventsSettingBloc()
      : super(
          const EventSubEventsSettingState(),
        ) {
    on<SubEventEnabledChanged>(_onSubEventEnabledChanged);
    on<SubEventSettingsChanged>(_onSubEventSettingsChange);
  }

  void _onSubEventEnabledChanged(
    SubEventEnabledChanged event,
    Emitter<EventSubEventsSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        subEventEnabled: event.subEventEnabled,
      ),
    );
  }

  void _onSubEventSettingsChange(
    SubEventSettingsChanged event,
    Emitter<EventSubEventsSettingState> emit,
  ) async {
    emit(
      state.copyWith(
        subEventSettings: event.subEventSettings,
      ),
    );
  }
}

@freezed
class EventGuestSettingEvent with _$EventGuestSettingEvent {
  const factory EventGuestSettingEvent.subEventEnabledChanged({
    required bool subEventEnabled,
  }) = SubEventEnabledChanged;

  const factory EventGuestSettingEvent.subEventSettingsChanged({
    SubEventSettings? subEventSettings,
  }) = SubEventSettingsChanged;
}

@freezed
class EventSubEventsSettingState with _$EventSubEventsSettingState {
  const factory EventSubEventsSettingState({
    @Default(false) bool subEventEnabled,
    SubEventSettings? subEventSettings,
  }) = _EventSubEventsSettingState;
}
