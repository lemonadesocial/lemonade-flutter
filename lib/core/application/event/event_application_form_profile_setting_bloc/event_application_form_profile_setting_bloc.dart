import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_application_profile_field.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_form_profile_setting_bloc.freezed.dart';

class EventApplicationFormProfileSettingBloc extends Bloc<
    EventApplicationFormProfileSettingBlocEvent,
    EventApplicationFormProfileSettingBlocState> {
  final Event? event;
  final List<EventApplicationProfileField>? initialProfileFields;
  EventApplicationFormProfileSettingBloc({
    this.event,
    this.initialProfileFields,
  }) : super(
          EventApplicationFormProfileSettingBlocState.initial(),
        ) {
    on<EventApplicationFormProfileSettingBlocEventToggleSelect>(
      onToggleSelect,
    );
    on<EventApplicationFormProfileSettingBlocEventToggleRequired>(
      onToggleRequired,
    );
    on<EventApplicationFormProfileSettingBlocEventPopulateInitialProfileFields>(
      onPopulateInitialProfileFields,
    );
    on<EventApplicationFormProfileSettingBlocEventSubmit>(
      onSubmit,
    );
    if (initialProfileFields != null) {
      add(
        EventApplicationFormProfileSettingBlocEvent
            .populateInitialProfileFields(),
      );
    }
  }

  final _eventRepository = getIt<EventRepository>();

  void onToggleSelect(
    EventApplicationFormProfileSettingBlocEventToggleSelect blocEvent,
    Emitter emit,
  ) {
    bool isExist = state.applicationProfileFields
        .any((element) => element.field == blocEvent.fieldKey);
    if (isExist) {
      List<EventApplicationProfileField> newApplicationProfileFields = state
          .applicationProfileFields
          .where((element) => element.field != blocEvent.fieldKey)
          .toList();
      emit(
        state.copyWith(
          applicationProfileFields: newApplicationProfileFields,
        ),
      );
    } else {
      emit(
        state.copyWith(
          applicationProfileFields: [
            ...state.applicationProfileFields,
            EventApplicationProfileField(
              field: blocEvent.fieldKey,
              required: false,
            ),
          ],
        ),
      );
    }
  }

  void onToggleRequired(
    EventApplicationFormProfileSettingBlocEventToggleRequired blocEvent,
    Emitter emit,
  ) {
    List<EventApplicationProfileField> updatedFields =
        state.applicationProfileFields
            .map(
              (element) => element.field == blocEvent.fieldKey
                  ? element.copyWith(required: blocEvent.isRequired)
                  : element,
            )
            .toList();
    emit(
      state.copyWith(
        applicationProfileFields: updatedFields,
      ),
    );
  }

  void onPopulateInitialProfileFields(
    EventApplicationFormProfileSettingBlocEventPopulateInitialProfileFields
        blocEvent,
    Emitter emit,
  ) {
    if (initialProfileFields == null) {
      return;
    }
    emit(
      EventApplicationFormProfileSettingBlocState(
        applicationProfileFields: initialProfileFields ?? [],
      ),
    );
  }

  void onSubmit(
    EventApplicationFormProfileSettingBlocEventSubmit blocEvent,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(
        status: EventApplicationFormProfileSettingStatus.loading,
      ),
    );
    final result = await _eventRepository.updateEvent(
      input: Input$EventInput(
        application_profile_fields: state.applicationProfileFields
            .map(
              (item) => Input$ApplicationProfileFieldInput(
                field: item.field ?? '',
                required: item.required,
              ),
            )
            .toList(),
      ),
      id: event?.id ?? '',
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EventApplicationFormProfileSettingStatus.error,
        ),
      ),
      (eventDetail) async {
        emit(
          state.copyWith(
            status: EventApplicationFormProfileSettingStatus.success,
          ),
        );
        emit(
          state.copyWith(
            status: EventApplicationFormProfileSettingStatus.initial,
          ),
        );
      },
    );
  }
}

@freezed
class EventApplicationFormProfileSettingBlocEvent
    with _$EventApplicationFormProfileSettingBlocEvent {
  factory EventApplicationFormProfileSettingBlocEvent.toggleSelect({
    required String fieldKey,
  }) = EventApplicationFormProfileSettingBlocEventToggleSelect;
  factory EventApplicationFormProfileSettingBlocEvent.toggleRequired({
    required String fieldKey,
    required bool isRequired,
  }) = EventApplicationFormProfileSettingBlocEventToggleRequired;
  factory EventApplicationFormProfileSettingBlocEvent.populateInitialProfileFields() =
      EventApplicationFormProfileSettingBlocEventPopulateInitialProfileFields;
  factory EventApplicationFormProfileSettingBlocEvent.submit() =
      EventApplicationFormProfileSettingBlocEventSubmit;
}

@freezed
class EventApplicationFormProfileSettingBlocState
    with _$EventApplicationFormProfileSettingBlocState {
  factory EventApplicationFormProfileSettingBlocState({
    @Default(EventApplicationFormProfileSettingStatus.initial)
    EventApplicationFormProfileSettingStatus status,
    required List<EventApplicationProfileField> applicationProfileFields,
  }) = _EventApplicationFormProfileSettingBlocState;

  factory EventApplicationFormProfileSettingBlocState.initial() =>
      EventApplicationFormProfileSettingBlocState(
        status: EventApplicationFormProfileSettingStatus.initial,
        applicationProfileFields: [],
      );
}

enum EventApplicationFormProfileSettingStatus {
  initial,
  loading,
  success,
  error,
}
