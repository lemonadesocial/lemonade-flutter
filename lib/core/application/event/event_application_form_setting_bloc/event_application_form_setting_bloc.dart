import 'package:app/core/domain/event/entities/event.dart';
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
  final Event? event;
  EventApplicationFormSettingBloc({
    this.event,
    this.initialQuestions,
  }) : super(
          EventApplicationFormSettingBlocState.initial(),
        ) {
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

  void onUpdateQuestion(
    EventApplicationFormSettingBlocEventUpdateQuestion blocEvent,
    Emitter emit,
  ) {
    final newQuestions = state.questions.asMap().entries.map((entry) {
      if (entry.key == blocEvent.index) {
        return blocEvent.question;
      }
      return entry.value;
    }).toList();
    emit(state.copyWith(questions: newQuestions));
    add(EventApplicationFormSettingBlocEvent.submitCreate(eventId: event?.id));
  }

  void onAddQuestion(
    EventApplicationFormSettingBlocEventAddQuestion blocEvent,
    Emitter emit,
  ) {
    List<Input$QuestionInput> newQuestions = [
      ...state.questions,
      blocEvent.question,
    ];

    emit(state.copyWith(questions: newQuestions));
    add(EventApplicationFormSettingBlocEvent.submitCreate(eventId: event?.id));
  }

  void onRemoveQuestion(
    EventApplicationFormSettingBlocEventRemoveQuestion blocEvent,
    Emitter emit,
  ) {
    List<Input$QuestionInput> newQuestions = [...state.questions];
    newQuestions.removeAt(blocEvent.index);
    emit(state.copyWith(questions: newQuestions));
  }

  void onSubmitCreate(
    EventApplicationFormSettingBlocEventSubmitCreate blocEvent,
    Emitter emit,
  ) async {
    emit(state.copyWith(status: EventApplicationFormStatus.loading));
    final result = await _eventRepository.submitEventApplicationQuestions(
      eventId: blocEvent.eventId ?? '',
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
    EventApplicationFormSettingBlocEventPopulateInitialQuestions blocEvent,
    Emitter emit,
  ) {
    if (initialQuestions == null) {
      return;
    }
    emit(
      EventApplicationFormSettingBlocState(
        questions: initialQuestions!
            .map(
              (item) => Input$QuestionInput(
                $_id: item.id,
                question: item.question ?? '',
                required: item.isRequired,
                type: item.type ?? Enum$QuestionType.text,
                select_type: item.selectType,
                options: item.options,
                position: item.position,
              ),
            )
            .toList(),
        isValid: false,
      ),
    );
  }
}

@freezed
class EventApplicationFormSettingBlocEvent
    with _$EventApplicationFormSettingBlocEvent {
  factory EventApplicationFormSettingBlocEvent.updateQuestion({
    required int index,
    required Input$QuestionInput question,
  }) = EventApplicationFormSettingBlocEventUpdateQuestion;
  factory EventApplicationFormSettingBlocEvent.addQuestion({
    required Input$QuestionInput question,
  }) = EventApplicationFormSettingBlocEventAddQuestion;
  factory EventApplicationFormSettingBlocEvent.removeQuestion({
    required int index,
  }) = EventApplicationFormSettingBlocEventRemoveQuestion;
  factory EventApplicationFormSettingBlocEvent.submitCreate({
    required String? eventId,
  }) = EventApplicationFormSettingBlocEventSubmitCreate;
  factory EventApplicationFormSettingBlocEvent.populateInitialQuestions() =
      EventApplicationFormSettingBlocEventPopulateInitialQuestions;
}

@freezed
class EventApplicationFormSettingBlocState
    with _$EventApplicationFormSettingBlocState {
  factory EventApplicationFormSettingBlocState({
    @Default(EventApplicationFormStatus.initial)
    EventApplicationFormStatus status,
    required List<Input$QuestionInput> questions,
    required bool isValid,
  }) = _EventApplicationFormSettingBlocState;

  factory EventApplicationFormSettingBlocState.initial() =>
      EventApplicationFormSettingBlocState(
        status: EventApplicationFormStatus.initial,
        questions: [],
        isValid: false,
      );
}

enum EventApplicationFormStatus {
  initial,
  loading,
  success,
  error,
}
