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
    on<EventDateTimeSettingsEventUpdateTempStart>(_onUpdateTempStart);
    on<EventDateTimeSettingsEventUpdateTempEnd>(_onUpdateTempEnd);
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
        tempStart: start,
        tempEnd: end,
        timezone: finalTimezone,
      ),
    );
  }

  Future<void> _onSaveChangesDateTime(
    EventDateTimeSettingsEventSaveChangesDateTime event,
    Emitter emit,
  ) async {
    final newStart = state.tempStart ?? state.start.value!;
    final newEnd = state.tempEnd ?? state.end.value!;
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
      state.tempStart!.year,
      state.tempStart!.month,
      state.tempStart!.day,
      state.tempStart!.hour,
      state.tempStart!.minute,
    );

    final newEnd = tz.TZDateTime(
      location,
      state.tempEnd!.year,
      state.tempEnd!.month,
      state.tempEnd!.day,
      state.tempEnd!.hour,
      state.tempEnd!.minute,
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
    final start = DateTimeFormz.dirty(state.start.value!);
    final end = DateTimeFormz.dirty(state.end.value!);
    emit(
      state.copyWith(
        start: start,
        end: end,
      ),
    );
  }

  void _onUpdateTempStart(
    EventDateTimeSettingsEventUpdateTempStart event,
    Emitter<EventDateTimeSettingsState> emit,
  ) {
    final tempStart = event.tempStart;
    var tempEnd = state.tempEnd ?? state.end.value!;

    // Edit mode
    if (event.event != null) {
      emit(
        state.copyWith(
          isValid: false,
          errorMessage: "",
          tempStart: tempStart,
          tempEnd: tempEnd,
        ),
      );
      return;
    }

    // If new start date is after or equal to end date, adjust end date
    if (!tempStart.isBefore(tempEnd)) {
      tempEnd = tz.TZDateTime(
        tz.getLocation(
          state.timezone ?? date_utils.DateUtils.getUserTimezoneOptionValue(),
        ),
        tempStart.year,
        tempStart.month,
        tempStart.day,
        tempStart.hour,
        tempStart.minute,
      ).add(
        const Duration(hours: 1),
      ); // Add 1 hour to ensure end is after start
    }

    emit(
      state.copyWith(
        isValid: false,
        errorMessage: "",
        tempStart: tempStart,
        tempEnd: tempEnd,
      ),
    );
  }

  void _onUpdateTempEnd(
    EventDateTimeSettingsEventUpdateTempEnd event,
    Emitter<EventDateTimeSettingsState> emit,
  ) {
    final tempEnd = event.tempEnd;
    var tempStart = state.tempStart ?? state.start.value!;

    // Edit mode
    if (event.event != null) {
      emit(
        state.copyWith(
          isValid: false,
          errorMessage: "",
          tempStart: tempStart,
          tempEnd: tempEnd,
        ),
      );
      return;
    }

    // If end date is before or equal to start date, adjust start date
    if (!tempEnd.isAfter(tempStart)) {
      tempStart = tz.TZDateTime(
        tz.getLocation(state.timezone ??
            date_utils.DateUtils.getUserTimezoneOptionValue()),
        tempEnd.year,
        tempEnd.month,
        tempEnd.day,
        tempEnd.hour,
        tempEnd.minute,
      ).subtract(
        const Duration(
          hours: 1,
        ),
      ); // Subtract 1 hour to ensure start is before end
    }
    emit(
      state.copyWith(
        isValid: false,
        errorMessage: "",
        tempStart: tempStart,
        tempEnd: tempEnd,
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
  }) = EventDateTimeSettingsEventSaveChangesDateTime;

  const factory EventDateTimeSettingsEvent.saveChangesTimezone({
    Event? event,
    required String timezone,
  }) = EventDateTimeSettingsEventSaveChangesTimezone;

  const factory EventDateTimeSettingsEvent.reset() =
      EventDateTimeSettingsEventReset;

  const factory EventDateTimeSettingsEvent.updateTempStart({
    required DateTime tempStart,
    Event? event,
  }) = EventDateTimeSettingsEventUpdateTempStart;

  const factory EventDateTimeSettingsEvent.updateTempEnd({
    required DateTime tempEnd,
    Event? event,
  }) = EventDateTimeSettingsEventUpdateTempEnd;
}

@freezed
class EventDateTimeSettingsState with _$EventDateTimeSettingsState {
  const factory EventDateTimeSettingsState({
    @Default(DateTimeFormz.pure()) DateTimeFormz start,
    @Default(DateTimeFormz.pure()) DateTimeFormz end,
    DateTime? tempStart,
    DateTime? tempEnd,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(false) bool isValid,
    @Default("") String errorMessage,
    String? timezone,
  }) = _EventDateTimeSettingsState;
}
