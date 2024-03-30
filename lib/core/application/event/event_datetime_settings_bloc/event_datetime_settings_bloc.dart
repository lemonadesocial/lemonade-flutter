import 'package:app/core/domain/form/datetime_formz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;

part 'event_datetime_settings_bloc.freezed.dart';

@lazySingleton
class EventDateTimeSettingsBloc
    extends Bloc<EventDateTimeSettingsEvent, EventDateTimeSettingsState> {
  EventDateTimeSettingsBloc() : super(const EventDateTimeSettingsState()) {
    on<EventDateTimeSettingsEventInit>(_onInit);
    on<StartDateChanged>(_onStartDateChanged);
    on<StartTimeChanged>(_onStartTimeChanged);
    on<EndDateChanged>(_onEndDateChanged);
    on<EndTimeChanged>(_onEndTimeChanged);
    on<TimezoneChanged>(_onTimezoneChanged);
  }

  Future<void> _onInit(
    EventDateTimeSettingsEventInit event,
    Emitter emit,
  ) async {
    final start = DateTimeFormz.dirty(event.startDateTime);
    final end = DateTimeFormz.dirty(event.endDateTime);
    final timezone = date_utils.DateUtils.getUserTimezoneOptionValue();
    emit(
      state.copyWith(start: start, end: end, timezone: timezone),
    );
  }

  Future<void> _onStartDateChanged(
    StartDateChanged event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {
    final startDate = DateTimeFormz.dirty(event.datetime);
    if (state.end.value != null && startDate.value!.isAfter(state.end.value!)) {
      emit(
        state.copyWith(
          start: startDate.isValid
              ? startDate
              : DateTimeFormz.dirty(DateTime.now()),
          end: const DateTimeFormz.pure(),
          isValid: Formz.validate([
            startDate,
            state.end,
          ]),
        ),
      );
    } else {
      emit(
        state.copyWith(
          start: startDate.isValid
              ? startDate
              : DateTimeFormz.dirty(DateTime.now()),
          isValid: Formz.validate([startDate, state.end]),
        ),
      );
    }
  }

  Future<void> _onStartTimeChanged(
    StartTimeChanged event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {
    final startTime = DateTimeFormz.dirty(event.datetime);
    emit(
      state.copyWith(
        start: startTime,
      ),
    );
  }

  Future<void> _onEndDateChanged(
    EndDateChanged event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {
    final endDate = DateTimeFormz.dirty(event.datetime);
    if (state.start.value != null &&
        endDate.value != null &&
        endDate.value!.isBefore(state.start.value!)) {
      emit(
        state.copyWith(
          start: const DateTimeFormz.pure(),
          end: endDate.isValid ? endDate : DateTimeFormz.dirty(DateTime.now()),
          isValid: Formz.validate([
            state.start,
            endDate,
          ]),
        ),
      );
    } else {
      emit(
        state.copyWith(
          end: endDate.isValid ? endDate : DateTimeFormz.dirty(DateTime.now()),
          isValid: Formz.validate([
            state.start,
            endDate,
          ]),
        ),
      );
    }
  }

  Future<void> _onEndTimeChanged(
    EndTimeChanged event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {
    final endTime = DateTimeFormz.dirty(event.datetime);
    emit(
      state.copyWith(
        end: endTime,
      ),
    );
  }

  Future<void> _onTimezoneChanged(
    TimezoneChanged event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {
    emit(
      state.copyWith(
        timezone: event.timezone,
      ),
    );
  }
}

@freezed
class EventDateTimeSettingsEvent with _$EventDateTimeSettingsEvent {
  factory EventDateTimeSettingsEvent.init({
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) = EventDateTimeSettingsEventInit;

  const factory EventDateTimeSettingsEvent.startDateChanged({
    required DateTime datetime,
  }) = StartDateChanged;

  const factory EventDateTimeSettingsEvent.startTimeChanged({
    required DateTime datetime,
  }) = StartTimeChanged;

  const factory EventDateTimeSettingsEvent.endDateChanged({
    required DateTime datetime,
  }) = EndDateChanged;

  const factory EventDateTimeSettingsEvent.endTimeChanged({
    required DateTime datetime,
  }) = EndTimeChanged;

  const factory EventDateTimeSettingsEvent.timezoneChanged({
    required String timezone,
  }) = TimezoneChanged;
}

@freezed
class EventDateTimeSettingsState with _$EventDateTimeSettingsState {
  const factory EventDateTimeSettingsState({
    @Default(DateTimeFormz.pure()) DateTimeFormz start,
    @Default(DateTimeFormz.pure()) DateTimeFormz end,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(false) bool isValid,
    String? timezone,
  }) = _EventDateTimeSettingsState;
}
