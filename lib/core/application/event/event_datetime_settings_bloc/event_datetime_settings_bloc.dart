import 'package:app/core/domain/form/datetime_formz.dart';
import 'package:app/i18n/i18n.g.dart';
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
    on<EndDateChanged>(_onEndDateChanged);
    on<TempStartDateTimeChanged>(_onTempStartDateTimeChanged);
    on<TempEndDateTimeChanged>(_onTempEndDateTimeChanged);
    on<EventDateTimeSettingsEventSaveChanges>(_onSaveChanges);
    on<TimezoneChanged>(_onTimezoneChanged);
    on<EventDateTimeSettingsEventReset>(_onReset);
  }

  Future<void> _onInit(
    EventDateTimeSettingsEventInit event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    final start = DateTimeFormz.dirty(event.startDateTime);
    final end = DateTimeFormz.dirty(event.endDateTime);
    final timezone = date_utils.DateUtils.getUserTimezoneOptionValue();
    emit(
      state.copyWith(
        start: start,
        end: end,
        tempStart: start,
        tempEnd: end,
        timezone: timezone,
      ),
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

  Future<void> _onTempStartDateTimeChanged(
    TempStartDateTimeChanged event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    final tempStartDate = DateTimeFormz.dirty(event.datetime);
    emit(
      state.copyWith(tempStart: tempStartDate),
    );
  }

  Future<void> _onTempEndDateTimeChanged(
    TempEndDateTimeChanged event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    final tempEndDate = DateTimeFormz.dirty(event.datetime);
    emit(
      state.copyWith(tempEnd: tempEndDate),
    );
  }

  Future<void> _onSaveChanges(
    EventDateTimeSettingsEventSaveChanges event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final tempStartDate = DateTimeFormz.dirty(state.tempStart.value!);
    final tempEndDate = DateTimeFormz.dirty(state.tempEnd.value!);
    if (tempStartDate.value!.isBefore(DateTime.now()) ||
        tempEndDate.value!.isBefore(DateTime.now())) {
      emit(
        state.copyWith(
          start: tempStartDate,
          end: tempEndDate,
          isValid: false,
          status: FormzSubmissionStatus.failure,
          errorMessage: t.event.dateTimeSettingError.mustBeFuture,
        ),
      );
    } else if (tempEndDate.value!.isBefore(tempStartDate.value!)) {
      emit(
        state.copyWith(
          start: tempStartDate,
          end: tempEndDate,
          isValid: false,
          status: FormzSubmissionStatus.failure,
          errorMessage: t.event.dateTimeSettingError.endMustAfterStart,
        ),
      );
    } else {
      emit(
        state.copyWith(
          start: tempStartDate,
          end: tempEndDate,
          tempStart: tempStartDate,
          tempEnd: tempEndDate,
          isValid: true,
          status: FormzSubmissionStatus.success,
        ),
      );
    }
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

  Future<void> _onReset(
    EventDateTimeSettingsEventReset event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    final start = DateTimeFormz.dirty(state.start.value!);
    final end = DateTimeFormz.dirty(state.end.value!);
    emit(
      state.copyWith(
        start: start,
        end: end,
        tempStart: start,
        tempEnd: end,
      ),
    );
  }
}

@freezed
class EventDateTimeSettingsEvent with _$EventDateTimeSettingsEvent {
  factory EventDateTimeSettingsEvent.init({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required DateTime tempStartDateTime,
    required DateTime tempEndDateTime,
  }) = EventDateTimeSettingsEventInit;

  const factory EventDateTimeSettingsEvent.startDateChanged({
    required DateTime datetime,
  }) = StartDateChanged;

  const factory EventDateTimeSettingsEvent.endDateChanged({
    required DateTime datetime,
  }) = EndDateChanged;

  const factory EventDateTimeSettingsEvent.tempStartDateTimeChanged({
    required DateTime datetime,
  }) = TempStartDateTimeChanged;

  const factory EventDateTimeSettingsEvent.tempEndDateTimeChanged({
    required DateTime datetime,
  }) = TempEndDateTimeChanged;

  const factory EventDateTimeSettingsEvent.timezoneChanged({
    required String timezone,
  }) = TimezoneChanged;

  const factory EventDateTimeSettingsEvent.saveChanges() =
      EventDateTimeSettingsEventSaveChanges;

  const factory EventDateTimeSettingsEvent.reset() =
      EventDateTimeSettingsEventReset;
}

@freezed
class EventDateTimeSettingsState with _$EventDateTimeSettingsState {
  const factory EventDateTimeSettingsState({
    @Default(DateTimeFormz.pure()) DateTimeFormz start,
    @Default(DateTimeFormz.pure()) DateTimeFormz end,
    @Default(DateTimeFormz.pure()) DateTimeFormz tempStart,
    @Default(DateTimeFormz.pure()) DateTimeFormz tempEnd,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(false) bool isValid,
    @Default("") String errorMessage,
    String? timezone,
  }) = _EventDateTimeSettingsState;
}
