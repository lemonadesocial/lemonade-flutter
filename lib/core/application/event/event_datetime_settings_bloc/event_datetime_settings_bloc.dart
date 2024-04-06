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
    on<EventDateTimeSettingsEventSaveChanges>(_onSaveChanges);
    on<TimezoneChanged>(_onTimezoneChanged);
    on<EventDateTimeSettingsEventReset>(_onReset);
  }
  final EventRepository eventRepository = getIt<EventRepository>();

  Future<void> _onInit(
    EventDateTimeSettingsEventInit event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
    final location = getLocation(
      event.timezone ?? date_utils.DateUtils.getUserTimezoneOptionValue(),
    );
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
        timezone: event.timezone,
      ),
    );
  }

  Future<void> _onSaveChanges(
    EventDateTimeSettingsEventSaveChanges event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final newStart = event.newStart;
    final newEnd = event.newEnd;
    if (newStart.isBefore(DateTime.now()) || newEnd.isBefore(DateTime.now())) {
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
        final location = getLocation(state.timezone ?? '');
        final startUtcDateTime = newStart
            .add(Duration(milliseconds: location.currentTimeZone.offset * -1));
        final endUtcDateTime = newEnd
            .add(Duration(milliseconds: location.currentTimeZone.offset * -1));

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
              status: FormzSubmissionStatus.success,
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

  const factory EventDateTimeSettingsEvent.timezoneChanged({
    required String timezone,
  }) = TimezoneChanged;

  const factory EventDateTimeSettingsEvent.saveChanges({
    Event? event,
    required DateTime newStart,
    required DateTime newEnd,
  }) = EventDateTimeSettingsEventSaveChanges;

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
