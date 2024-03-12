import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_form_setting_bloc.freezed.dart';

// TODO: Temporary due to backend will refactor to this soon
class Input$EventApplicationQuestion {
  Input$EventApplicationQuestion({
    required this.label,
    required this.required,
  });

  final String label;
  final bool required;

  copyWith({
    String? label,
    bool? required,
  }) {
    return Input$EventApplicationQuestion(
      label: label ?? this.label,
      required: required ?? this.required,
    );
  }
}

class EventApplicationFormSettingBloc extends Bloc<
    EventApplicationFormSettingBlocEvent,
    EventApplicationFormSettingBlocState> {
  EventApplicationFormSettingBloc()
      : super(
          EventApplicationFormSettingBlocState(
            questions: [],
            isValid: false,
          ),
        ) {
    on<EventApplicationFormSettingBlocEventUpdateQuestion>(onUpdateQuestion);
    on<EventApplicationFormSettingBlocEventAddQuestion>(onAddQuestion);
    on<EventApplicationFormSettingBlocEventRemoveQuestion>(onRemoveQuestion);
    on<EventApplicationFormSettingBlocEventSubmitCreate>(onSubmitCreate);
  }

  final _eventRepository = getIt<EventRepository>();

  void onUpdateQuestion(
    EventApplicationFormSettingBlocEventUpdateQuestion event,
    Emitter emit,
  ) {
    final newQuestions = state.questions.asMap().entries.map((entry) {
      if (entry.key == event.index) {
        return event.questions;
      }
      return entry.value;
    }).toList();
    emit(
      _validate(state.copyWith(questions: newQuestions)),
    );
  }

  void onAddQuestion(
    EventApplicationFormSettingBlocEventAddQuestion event,
    Emitter emit,
  ) {
    List<Input$EventApplicationQuestion> newQuestions = [
      ...state.questions,
      Input$EventApplicationQuestion(label: "", required: true),
    ];

    emit(
      _validate(
        state.copyWith(questions: newQuestions),
      ),
    );
  }

  void onRemoveQuestion(
    EventApplicationFormSettingBlocEventRemoveQuestion event,
    Emitter emit,
  ) {
    List<Input$EventApplicationQuestion> newQuestions = [...state.questions];
    newQuestions.removeAt(event.index);

    emit(
      _validate(
        state.copyWith(questions: newQuestions),
      ),
    );
  }

  EventApplicationFormSettingBlocState _validate(
    EventApplicationFormSettingBlocState state,
  ) {
    final allQuestionsIsValid = state.questions
        .map((question) => question.label != '')
        .every((element) => element == true);
    return state.copyWith(
      isValid: allQuestionsIsValid,
    );
  }

  void onSubmitCreate(
    EventApplicationFormSettingBlocEventSubmitCreate event,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: EventApplicationFormStatus.loading));
    final listQuestionsString =
        state.questions.map((question) => question.label).toList();
    final result = await _eventRepository.createEventApplicationQuestions(
      eventId: event.eventId ?? '',
      questions: listQuestionsString,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: EventApplicationFormStatus.error)),
      (questions) {
        emit(state.copyWith(status: EventApplicationFormStatus.success));
      },
    );
  }
}

@freezed
class EventApplicationFormSettingBlocEvent
    with _$EventApplicationFormSettingBlocEvent {
  factory EventApplicationFormSettingBlocEvent.updateQuestion({
    required int index,
    required Input$EventApplicationQuestion questions,
  }) = EventApplicationFormSettingBlocEventUpdateQuestion;
  factory EventApplicationFormSettingBlocEvent.addQuestion() =
      EventApplicationFormSettingBlocEventAddQuestion;
  factory EventApplicationFormSettingBlocEvent.removeQuestion({
    required int index,
  }) = EventApplicationFormSettingBlocEventRemoveQuestion;
  factory EventApplicationFormSettingBlocEvent.submitCreate({
    required String? eventId,
  }) = EventApplicationFormSettingBlocEventSubmitCreate;
}

@freezed
class EventApplicationFormSettingBlocState
    with _$EventApplicationFormSettingBlocState {
  factory EventApplicationFormSettingBlocState({
    @Default(EventApplicationFormStatus.initial)
    EventApplicationFormStatus status,
    required List<Input$EventApplicationQuestion> questions,
    required bool isValid,
  }) = _EventApplicationFormSettingBlocState;
}

enum EventApplicationFormStatus {
  initial,
  loading,
  success,
  error,
}
