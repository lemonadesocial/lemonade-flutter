import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/form/datetime_formz.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:timezone/timezone.dart' as tz;

part 'event_datetime_settings_bloc.freezed.dart';

@lazySingleton
class EventDateTimeSettingsBloc
    extends Bloc<EventDateTimeSettingsEvent, EventDateTimeSettingsState> {
  EventDateTimeSettingsBloc() : super(const EventDateTimeSettingsState()) {
    on<EventDateTimeSettingsEventInit>(_onInit);
    on<EventDateTimeSettingsEventSaveChangesDateTime>(_onSaveChangesDateTime);
    on<EventDateTimeSettingsEventSaveChangesTimezone>(_onSaveChangesTimezone);
    on<EventDateTimeSettingsEventReset>(_onReset);
  }
  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onInit(
    EventDateTimeSettingsEventInit event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    final finalTimezone =
        event.timezone ?? date_utils.DateUtils.getUserTimezoneOptionValue();
    final location = tz.getLocation(finalTimezone);
    final start = tz.TZDateTime.from(event.startDateTime, location);
    final end = tz.TZDateTime.from(event.endDateTime, location);
    emit(
      state.copyWith(
        start: DateTimeFormz.dirty(start),
        end: DateTimeFormz.dirty(end),
        timezone: finalTimezone,
      ),
    );
  }

  Future<void> _onSaveChangesDateTime(
    EventDateTimeSettingsEventSaveChangesDateTime event,
    Emitter emit,
  ) async {
    final newStart = event.newStart;
    final newEnd = event.newEnd;
    if (newStart.isBefore(DateTime.now())) {
      emit(
        state.copyWith(
          start: DateTimeFormz.dirty(newStart),
          end: DateTimeFormz.dirty(newEnd),
          isValid: false,
          status: FormzSubmissionStatus.failure,
          errorMessage: t.event.dateTimeSettingError.mustBeFuture,
        ),
      );
    } else if (newEnd.isBefore(newStart)) {
      emit(
        state.copyWith(
          start: DateTimeFormz.dirty(newStart),
          end: DateTimeFormz.dirty(newEnd),
          isValid: false,
          status: FormzSubmissionStatus.failure,
          errorMessage: t.event.dateTimeSettingError.endMustAfterStart,
        ),
      );
    } else {
      // Edit mode
      if (event.event != null) {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        final result = await eventRepository.updateEvent(
          input: Input$EventInput(
            start: newStart.toUtc(),
            end: newEnd.toUtc(),
          ),
          id: event.event?.id ?? '',
        );
        result.fold(
          (failure) =>
              emit(state.copyWith(status: FormzSubmissionStatus.failure)),
          (eventDetail) => emit(
            state.copyWith(
              isValid: true,
              status: FormzSubmissionStatus.success,
              start: DateTimeFormz.dirty(newStart),
              end: DateTimeFormz.dirty(newEnd),
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            isValid: true,
            status: FormzSubmissionStatus.success,
            start: DateTimeFormz.dirty(newStart),
            end: DateTimeFormz.dirty(newEnd),
          ),
        );
      }
    }
  }

  Future<void> _onSaveChangesTimezone(
    EventDateTimeSettingsEventSaveChangesTimezone event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final location = tz.getLocation(event.timezone);
    final newStart = tz.TZDateTime(
      location,
      state.start.value!.year,
      state.start.value!.month,
      state.start.value!.day,
      state.start.value!.hour,
      state.start.value!.minute,
    );

    final newEnd = tz.TZDateTime(
      location,
      state.end.value!.year,
      state.end.value!.month,
      state.end.value!.day,
      state.end.value!.hour,
      state.end.value!.minute,
    );
    // Edit mode
    if (event.event != null) {
      final result = await eventRepository.updateEvent(
        input: Input$EventInput(
          start: newStart.toUtc(),
          end: newEnd.toUtc(),
          timezone: event.timezone,
        ),
        id: event.event?.id ?? '',
      );
      result.fold(
        (failure) =>
            emit(state.copyWith(status: FormzSubmissionStatus.failure)),
        (eventDetail) => emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
            isValid: true,
            timezone: event.timezone,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          start: DateTimeFormz.dirty(newStart),
          end: DateTimeFormz.dirty(newEnd),
          timezone: event.timezone,
          isValid: true,
          status: FormzSubmissionStatus.success,
        ),
      );
    }
  }

  Future<void> _onReset(
    EventDateTimeSettingsEventReset event,
    Emitter<EventDateTimeSettingsState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }
}

@freezed
class EventDateTimeSettingsEvent with _$EventDateTimeSettingsEvent {
  factory EventDateTimeSettingsEvent.init({
    required DateTime endDateTime,
    required DateTime startDateTime,
    String? timezone,
  }) = EventDateTimeSettingsEventInit;

  const factory EventDateTimeSettingsEvent.saveChangesDateTime({
    Event? event,
    required DateTime newStart,
    required DateTime newEnd,
  }) = EventDateTimeSettingsEventSaveChangesDateTime;

  const factory EventDateTimeSettingsEvent.saveChangesTimezone({
    Event? event,
    required String timezone,
  }) = EventDateTimeSettingsEventSaveChangesTimezone;

  const factory EventDateTimeSettingsEvent.reset() =
      EventDateTimeSettingsEventReset;
}

@freezed
class EventDateTimeSettingsState with _$EventDateTimeSettingsState {
  const factory EventDateTimeSettingsState({
    @Default(DateTimeFormz.pure()) DateTimeFormz start,
    @Default(DateTimeFormz.pure()) DateTimeFormz end,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(false) bool isValid,
    @Default("") String errorMessage,
    String? timezone,
  }) = _EventDateTimeSettingsState;
}
