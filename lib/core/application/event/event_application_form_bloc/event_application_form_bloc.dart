import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_form_bloc.freezed.dart';

class EventApplicationFormBloc
    extends Bloc<EventApplicationFormBlocEvent, EventApplicationFormBlocState> {
  final List<EventApplicationQuestion>? initialQuestions;
  EventApplicationFormBloc({this.initialQuestions})
      : super(
          EventApplicationFormBlocState(
            fieldsState: {},
            isValid: false,
            answers: [],
          ),
        ) {
    on<EventApplicationFormBlocEventInitFieldState>(initFieldState);
    on<EventApplicationFormBlocEventUpdateField>(updateField);
    on<EventApplicationFormBlocEventUpdateAnswer>(updateAnswer);
  }

  void initFieldState(
    EventApplicationFormBlocEventInitFieldState event,
    Emitter emit,
  ) {
    final user = event.user;
    final applicationProfileFields =
        event.event?.applicationProfileFields ?? [];
    final applicationQuestions = event.event?.applicationQuestions ?? [];
    final Map<String, String> initialFieldState = {};
    final userMap = user?.toJson();
    for (var applicationProfileField in applicationProfileFields) {
      final key = applicationProfileField.field ?? '';
      final value = userMap![StringUtils.snakeToCamel(key)];
      initialFieldState[key] = value != null ? value.toString() : "";
    }
    emit(
      state.copyWith(
        fieldsState: initialFieldState,
        answers: applicationQuestions
            .map(
              (item) => Input$EventApplicationAnswerInput(
                answer: "",
                question: item.id ?? '',
              ),
            )
            .toList(),
      ),
    );
  }

  void updateField(
    EventApplicationFormBlocEventUpdateField event,
    Emitter emit,
  ) {
    final Map<String, String> newFieldState = {...state.fieldsState};
    newFieldState[event.key!] = event.value!;
    emit(
      _validate(
        state: state.copyWith(fieldsState: newFieldState),
        event: event.event,
      ),
    );
  }

  void updateAnswer(
    EventApplicationFormBlocEventUpdateAnswer event,
    Emitter emit,
  ) {
    // final applicationQuestions = event.event?.applicationQuestions ?? [];
    final newAnswers = state.answers.map((answer) {
      if (answer.question == event.questionId) {
        return answer.copyWith(answer: event.answer);
      }
      return answer;
    }).toList();
    emit(
      _validate(
        state: state.copyWith(answers: newAnswers),
        event: event.event,
      ),
    );
  }

  EventApplicationFormBlocState _validate({
    required EventApplicationFormBlocState state,
    Event? event,
  }) {
    final applicationProfileFields = event?.applicationProfileFields ?? [];
    final applicationQuestions = event?.applicationQuestions ?? [];
    // Check profile required fields valid
    final allProfileRequiredFields = state.fieldsState.entries.where((entry) {
      final isRequiredField = applicationProfileFields?.any(
        (applicationProfileField) =>
            applicationProfileField.field == entry.key &&
            applicationProfileField.required == true,
      );
      return isRequiredField == true;
    });

    final isValidProfileFields = allProfileRequiredFields.every(
      (allProfileRequiredField) => !allProfileRequiredField.value.isNullOrEmpty,
    );

    // Check questions required valid
    final allAnswerRequiredFields = state.answers.where((answer) {
      final isRequiredField = applicationQuestions?.any(
        (applicationQuestion) =>
            applicationQuestion.id == answer.question &&
            applicationQuestion.isRequired == true,
      );
      return isRequiredField == true;
    });

    final isValidAnswersField = allAnswerRequiredFields.every(
      (allProfileRequiredField) =>
          !allProfileRequiredField.answer.isNullOrEmpty,
    );
    return state.copyWith(isValid: isValidProfileFields && isValidAnswersField);
  }
}

@freezed
class EventApplicationFormBlocEvent with _$EventApplicationFormBlocEvent {
  factory EventApplicationFormBlocEvent.initFieldState({
    Event? event,
    User? user,
  }) = EventApplicationFormBlocEventInitFieldState;
  factory EventApplicationFormBlocEvent.updateField({
    required Event? event,
    String? key,
    String? value,
  }) = EventApplicationFormBlocEventUpdateField;
  factory EventApplicationFormBlocEvent.updateAnswer({
    required Event? event,
    required String questionId,
    required String answer,
  }) = EventApplicationFormBlocEventUpdateAnswer;
}

@freezed
class EventApplicationFormBlocState with _$EventApplicationFormBlocState {
  factory EventApplicationFormBlocState({
    @Default({}) Map<String, String> fieldsState,
    required List<Input$EventApplicationAnswerInput> answers,
    required bool isValid,
  }) = _EventApplicationFormBlocState;
}
