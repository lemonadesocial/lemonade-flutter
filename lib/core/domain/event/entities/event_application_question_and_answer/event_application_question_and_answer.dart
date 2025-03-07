import 'package:app/core/data/event/dtos/event_application_question_and_answer_dto/event_application_question_and_answer_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_question_and_answer.freezed.dart';
part 'event_application_question_and_answer.g.dart';

@freezed
class EventApplicationQuestionAndAnswer
    with _$EventApplicationQuestionAndAnswer {
  factory EventApplicationQuestionAndAnswer({
    required String question,
    String? answer,
    List<String>? answers,
  }) = _EventApplicationQuestionAndAnswer;

  factory EventApplicationQuestionAndAnswer.fromDto(
    EventApplicationQuestionAndAnswerDto dto,
  ) =>
      EventApplicationQuestionAndAnswer(
        question: dto.question,
        answer: dto.answer,
        answers: dto.answers,
      );

  factory EventApplicationQuestionAndAnswer.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$EventApplicationQuestionAndAnswerFromJson(json);
}
