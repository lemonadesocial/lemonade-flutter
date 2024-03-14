import 'package:app/core/data/event/dtos/event_application_answer_dto/event_application_answer_dto.dart';
import 'package:app/core/domain/event/entities/event_application_question.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_answer.freezed.dart';

@freezed
class EventApplicationAnswer with _$EventApplicationAnswer {
  EventApplicationAnswer._();

  factory EventApplicationAnswer({
    String? id,
    String? answer,
    String? question,
    String? user,
    EventApplicationQuestion? questionExpanded,
  }) = _EventApplicationAnswer;

  factory EventApplicationAnswer.fromDto(EventApplicationAnswerDto dto) =>
      EventApplicationAnswer(
        id: dto.id,
        answer: dto.answer,
        question: dto.question,
        user: dto.user,
        questionExpanded: dto.questionExpanded != null
            ? EventApplicationQuestion.fromDto(dto.questionExpanded!)
            : null,
      );
}
