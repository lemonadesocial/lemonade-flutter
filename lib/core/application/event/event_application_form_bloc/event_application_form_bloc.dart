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
    final eventProfileFields = event.event?.applicationProfileFields ?? [];
    final applicationQuestions = event.event?.applicationQuestions ?? [];
    final Map<String, String> initialFieldState = {};
    final userMap = user?.toJson();
    for (var applicationProfileField in eventProfileFields) {
      final key = applicationProfileField.field ?? '';
      initialFieldState[key] =
          userMap![StringUtils.snakeToCamel(key)].toString();
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
    emit(_validate(state.copyWith(fieldsState: newFieldState)));
  }

  void updateAnswer(
    EventApplicationFormBlocEventUpdateAnswer event,
    Emitter emit,
  ) {
    final newAnswers = state.answers.map((answer) {
      if (answer.question == event.questionId) {
        return answer.copyWith(answer: event.answer);
      }
      return answer;
    }).toList();
    emit(
      _validate(state.copyWith(answers: newAnswers)),
    );
  }

  EventApplicationFormBlocState _validate(
    EventApplicationFormBlocState state,
  ) {
    final isValidProfileFields =
        state.fieldsState.values.every((value) => !value.isNullOrEmpty);
    final isValidAnswers =
        state.answers.every((answer) => !answer.answer.isNullOrEmpty);
    return state.copyWith(isValid: isValidProfileFields && isValidAnswers);
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
  factory EventApplicationFormBlocEvent.updateAnswer({
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
