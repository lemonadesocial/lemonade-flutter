import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_question_dto.freezed.dart';
part 'event_application_question_dto.g.dart';

@freezed
class EventApplicationQuestionDto with _$EventApplicationQuestionDto {
  factory EventApplicationQuestionDto({
    @JsonKey(name: '_id') String? id,
    String? question,
  }) = _EventApplicationQuestionDto;

  factory EventApplicationQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$EventApplicationQuestionDtoFromJson(json);
}
