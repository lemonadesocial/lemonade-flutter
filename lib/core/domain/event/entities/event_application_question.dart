import 'package:app/core/data/event/dtos/event_application_question_dto/event_application_question_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_question.freezed.dart';
part 'event_application_question.g.dart';

@freezed
class EventApplicationQuestion with _$EventApplicationQuestion {
  factory EventApplicationQuestion({
    String? id,
    String? question,
    bool? isRequired,
    int? position,
    Enum$QuestionType? type,
    List<String>? options,
    Enum$SelectType? selectType,
  }) = _EventApplicationQuestion;

  factory EventApplicationQuestion.fromJson(Map<String, dynamic> json) =>
      _$EventApplicationQuestionFromJson(json);

  factory EventApplicationQuestion.fromDto(EventApplicationQuestionDto dto) =>
      EventApplicationQuestion(
        id: dto.id,
        question: dto.question,
        isRequired: dto.isRequired,
        position: dto.position,
        type: dto.type,
        options: dto.options,
        selectType: dto.selectType,
      );
}
