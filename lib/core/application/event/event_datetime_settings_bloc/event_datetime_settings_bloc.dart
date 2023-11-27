import 'package:app/core/domain/form/datetime_formz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_datetime_settings_bloc.freezed.dart';

class EventDateTimeSettingsBloc
    extends Bloc<EventDateTimeSettingsEvent, EventDateTimeSettingsState> {
  EventDateTimeSettingsBloc() : super(const EventDateTimeSettingsState()) {
    on<EventDateTimeSettingsEventInit>(_onInit);
    on<StartDateChanged>(_onStartDateChanged);
    on<StartTimeChanged>(_onStartTimeChanged);
    on<EndDateChanged>(_onEndDateChanged);
    on<EndTimeChanged>(_onEndTimeChanged);
  }

  Future<void> _onInit(
    EventDateTimeSettingsEventInit event,
    Emitter emit,
  ) async {
    if (kDebugMode) {
      print("......");
      print('init');
    }
  }

  Future<void> _onStartDateChanged(
    StartDateChanged event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {}

  Future<void> _onStartTimeChanged(
    StartTimeChanged event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {}

  Future<void> _onEndDateChanged(
    EndDateChanged event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {}

  Future<void> _onEndTimeChanged(
    EndTimeChanged event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {}
}

@freezed
class EventDateTimeSettingsEvent with _$EventDateTimeSettingsEvent {
  factory EventDateTimeSettingsEvent.init() = EventDateTimeSettingsEventInit;

  const factory EventDateTimeSettingsEvent.startDateChanged({
    required bool virtual,
  }) = StartDateChanged;

  const factory EventDateTimeSettingsEvent.startTimeChanged({
    required bool virtual,
  }) = StartTimeChanged;

  const factory EventDateTimeSettingsEvent.endDateChanged({
    required bool virtual,
  }) = EndDateChanged;

  const factory EventDateTimeSettingsEvent.endTimeChanged({
    required bool virtual,
  }) = EndTimeChanged;

  const factory EventDateTimeSettingsEvent.formSubmitted() = FormSubmitted;
}

@freezed
class EventDateTimeSettingsState with _$EventDateTimeSettingsState {
  const factory EventDateTimeSettingsState({
    @Default(DateTimeFormz.pure()) DateTimeFormz start,
    @Default(DateTimeFormz.pure()) DateTimeFormz end,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _EventDateTimeSettingsState;
}
