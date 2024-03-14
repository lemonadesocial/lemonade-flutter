import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_form_setting_bloc.freezed.dart';

class EventApplicationFormSettingBloc extends Bloc<
    EventApplicationFormSettingBlocEvent,
    EventApplicationFormSettingBlocState> {
  final List<EventApplicationQuestion>? initialQuestions;
  EventApplicationFormSettingBloc({
    this.initialQuestions,
  }) : super(
          EventApplicationFormSettingBlocState.initial(),
        ) {
    on<EventApplicationFormSettingBlocEventUpdateRequiredProfileFields>(
        onUpdateRequiredProfileFields);
    on<EventApplicationFormSettingBlocEventUpdateQuestion>(onUpdateQuestion);
    on<EventApplicationFormSettingBlocEventAddQuestion>(onAddQuestion);
    on<EventApplicationFormSettingBlocEventRemoveQuestion>(onRemoveQuestion);
    on<EventApplicationFormSettingBlocEventSubmitCreate>(onSubmitCreate);
    on<EventApplicationFormSettingBlocEventPopulateInitialQuestions>(
      onPopulateInitialQuestions,
    );
    if (initialQuestions != null) {
      add(EventApplicationFormSettingBlocEvent.populateInitialQuestions());
    }
  }

  final _eventRepository = getIt<EventRepository>();

  void onUpdateRequiredProfileFields(
    EventApplicationFormSettingBlocEventUpdateRequiredProfileFields event,
    Emitter emit,
  ) {
    emit(
      state.copyWith(requiredProfileFields: event.requiredProfileFields),
    );
  }

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
    List<Input$QuestionInput> newQuestions = [
      ...state.questions,
      Input$QuestionInput(question: "", required: false),
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
    List<Input$QuestionInput> newQuestions = [...state.questions];
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
        .map((question) => question.question != '')
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
    final result = await _eventRepository.submitEventApplicationQuestions(
      eventId: event.eventId ?? '',
      questions: state.questions,
    );
    result.fold(
      (failure) =>
          emit(state.copyWith(status: EventApplicationFormStatus.error)),
      (result) {
        emit(state.copyWith(status: EventApplicationFormStatus.success));
      },
    );
  }

  void onPopulateInitialQuestions(
    EventApplicationFormSettingBlocEventPopulateInitialQuestions event,
    Emitter emit,
  ) {
    if (initialQuestions == null) {
      return;
    }
    emit(
      _validate(
        EventApplicationFormSettingBlocState(
          questions: initialQuestions!
              .map(
                (item) => Input$QuestionInput(
                  $_id: item.id,
                  question: item.question ?? '',
                  required: item.required,
                ),
              )
              .toList(),
          isValid: false,
          requiredProfileFields: [],
        ),
      ),
    );
  }
}

@freezed
class EventApplicationFormSettingBlocEvent
    with _$EventApplicationFormSettingBlocEvent {
  factory EventApplicationFormSettingBlocEvent.updateQuestion({
    required int index,
    required Input$QuestionInput questions,
  }) = EventApplicationFormSettingBlocEventUpdateQuestion;
  factory EventApplicationFormSettingBlocEvent.addQuestion() =
      EventApplicationFormSettingBlocEventAddQuestion;
  factory EventApplicationFormSettingBlocEvent.removeQuestion({
    required int index,
  }) = EventApplicationFormSettingBlocEventRemoveQuestion;
  factory EventApplicationFormSettingBlocEvent.submitCreate({
    required String? eventId,
  }) = EventApplicationFormSettingBlocEventSubmitCreate;
  factory EventApplicationFormSettingBlocEvent.populateInitialQuestions() =
      EventApplicationFormSettingBlocEventPopulateInitialQuestions;
  factory EventApplicationFormSettingBlocEvent.updateRequiredProfileFields({
    required List<String> requiredProfileFields,
  }) = EventApplicationFormSettingBlocEventUpdateRequiredProfileFields;
}

@freezed
class EventApplicationFormSettingBlocState
    with _$EventApplicationFormSettingBlocState {
  factory EventApplicationFormSettingBlocState({
    @Default(EventApplicationFormStatus.initial)
    EventApplicationFormStatus status,
    required List<Input$QuestionInput> questions,
    required bool isValid,
    required List<String> requiredProfileFields,
  }) = _EventApplicationFormSettingBlocState;

  factory EventApplicationFormSettingBlocState.initial() =>
      EventApplicationFormSettingBlocState(
        status: EventApplicationFormStatus.initial,
        questions: [
          Input$QuestionInput(question: "", required: false),
        ],
        isValid: false,
        requiredProfileFields: [],
      );
}

enum EventApplicationFormStatus {
  initial,
  loading,
  success,
  error,
}
