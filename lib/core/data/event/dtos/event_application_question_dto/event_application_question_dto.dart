import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
part 'event_application_question_dto.freezed.dart';
part 'event_application_question_dto.g.dart';

@freezed
class EventApplicationQuestionDto with _$EventApplicationQuestionDto {
  factory EventApplicationQuestionDto({
    @JsonKey(name: '_id') String? id,
    String? question,
    @JsonKey(name: 'required') bool? isRequired,
    int? position,
    Enum$QuestionType? type,
    List<String>? options,
    @JsonKey(name: 'select_type') Enum$SelectType? selectType,
  }) = _EventApplicationQuestionDto;

  factory EventApplicationQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$EventApplicationQuestionDtoFromJson(json);
}
