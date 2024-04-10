import 'package:app/core/data/event/dtos/event_application_question_dto/event_application_question_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_answer_dto.g.dart';
part 'event_application_answer_dto.freezed.dart';

@freezed
class EventApplicationAnswerDto with _$EventApplicationAnswerDto {
  @JsonSerializable(explicitToJson: true)
  factory EventApplicationAnswerDto({
    @JsonKey(name: '_id') String? id,
    String? answer,
    String? question,
    String? user,
    @JsonKey(name: 'question_expanded')
    EventApplicationQuestionDto? questionExpanded,
  }) = _EventApplicationAnswerDto;

  factory EventApplicationAnswerDto.fromJson(Map<String, dynamic> json) =>
      _$EventApplicationAnswerDtoFromJson(json);
}
