import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_form_bloc.freezed.dart';

class EventApplicationFormBloc
    extends Bloc<EventApplicationFormBlocEvent, EventApplicationFormBlocState> {
  EventApplicationFormBloc()
      : super(
          EventApplicationFormBlocState(
            fieldsState: {},
            isValid: false,
          ),
        ) {
    on<EventApplicationFormBlocEventInitFieldState>(initFieldState);
    on<EventApplicationFormBlocEventUpdateField>(updateField);
  }

  void initFieldState(
    EventApplicationFormBlocEventInitFieldState event,
    Emitter emit,
  ) {
    final user = event.user;
    final eventProfileFields = event.event?.requiredProfileFields ?? [];

    final Map<String, String> initialFieldState = {};
    final userMap = user?.toJson();
    for (var key in eventProfileFields) {
      initialFieldState[key] =
          userMap![StringUtils.snakeToCamel(key)].toString();
    }
    emit(state.copyWith(fieldsState: initialFieldState));
  }

  void updateField(
    EventApplicationFormBlocEventUpdateField event,
    Emitter emit,
  ) {
    if (event.key == null || event.value == null) {
      return;
    }
    final Map<String, String> newFieldState = {...state.fieldsState};
    newFieldState[event.key!] = event.value!;
    emit(_validate(state.copyWith(fieldsState: newFieldState)));
  }

  EventApplicationFormBlocState _validate(
    EventApplicationFormBlocState state,
  ) {
    final isValid =
        state.fieldsState.values.every((value) => !value.isNullOrEmpty);
    return state.copyWith(isValid: isValid);
  }
}

@freezed
class EventApplicationFormBlocEvent with _$EventApplicationFormBlocEvent {
  factory EventApplicationFormBlocEvent.initFieldState({
    Event? event,
    User? user,
  }) = EventApplicationFormBlocEventInitFieldState;
  factory EventApplicationFormBlocEvent.updateField({
    String? key,
    String? value,
  }) = EventApplicationFormBlocEventUpdateField;
}

@freezed
class EventApplicationFormBlocState with _$EventApplicationFormBlocState {
  factory EventApplicationFormBlocState({
    @Default({}) Map<String, String> fieldsState,
    required bool isValid,
  }) = _EventApplicationFormBlocState;
}
