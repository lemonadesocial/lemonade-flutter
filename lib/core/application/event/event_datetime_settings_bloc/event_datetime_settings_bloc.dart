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
import 'package:timezone/timezone.dart';

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
    final location = getLocation(finalTimezone);
    final start = DateTimeFormz.dirty(
      event.startDateTime
          .add(Duration(milliseconds: location.currentTimeZone.offset)),
    );
    final end = DateTimeFormz.dirty(
      event.endDateTime
          .add(Duration(milliseconds: location.currentTimeZone.offset)),
    );
    emit(
      state.copyWith(
        start: start,
        end: end,
        timezone: finalTimezone,
      ),
    );
  }

  Future<void> _onSaveChangesDateTime(
    EventDateTimeSettingsEventSaveChangesDateTime event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final newStart = event.newStart;
    final newEnd = event.newEnd;
    final location = getLocation(state.timezone ?? '');
    final startUtcDateTime = newStart
        .add(Duration(milliseconds: location.currentTimeZone.offset * -1));
    final endUtcDateTime = newEnd
        .add(Duration(milliseconds: location.currentTimeZone.offset * -1));

    final now = DateTime.now();
    final tomorrowMidnight = DateTime.utc(now.year, now.month, now.day + 1);
    if (newStart.isBefore(tomorrowMidnight) ||
        newEnd.isBefore(tomorrowMidnight)) {
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
        final result = await eventRepository.updateEvent(
          input: Input$EventInput(
            start: DateTime.parse(startUtcDateTime.toIso8601String()),
            end: DateTime.parse(endUtcDateTime.toIso8601String()),
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
            start: DateTimeFormz.dirty(newStart),
            end: DateTimeFormz.dirty(newEnd),
            isValid: true,
            status: FormzSubmissionStatus.success,
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
    // Edit mode
    if (event.event != null) {
      final location = getLocation(event.timezone);
      final startUtcDateTime = state.start.value!
          .add(Duration(milliseconds: location.currentTimeZone.offset * -1));
      final endUtcDateTime = state.end.value!
          .add(Duration(milliseconds: location.currentTimeZone.offset * -1));

      final result = await eventRepository.updateEvent(
        input: Input$EventInput(
          start: DateTime.parse(startUtcDateTime.toIso8601String()),
          end: DateTime.parse(endUtcDateTime.toIso8601String()),
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
    final start = DateTimeFormz.dirty(state.start.value!);
    final end = DateTimeFormz.dirty(state.end.value!);
    emit(
      state.copyWith(
        start: start,
        end: end,
      ),
    );
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
