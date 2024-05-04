import 'package:app/core/data/event/dtos/event_frequent_question_dto/event_frequent_question_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_frequent_question.freezed.dart';
part 'event_frequent_question.g.dart';

@freezed
class EventFrequentQuestion with _$EventFrequentQuestion {
  const EventFrequentQuestion._();

  factory EventFrequentQuestion({
    String? id,
    String? question,
    String? answer,
  }) = _EventFrequentQuestion;

  factory EventFrequentQuestion.fromDto(EventFrequentQuestionDto dto) =>
      EventFrequentQuestion(
        id: dto.id,
        question: dto.question,
        answer: dto.answer,
      );
  factory EventFrequentQuestion.fromJson(Map<String, dynamic> json) =>
      _$EventFrequentQuestionFromJson(json);
}
