import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_question_and_answer_dto.freezed.dart';
part 'event_application_question_and_answer_dto.g.dart';

@freezed
class EventApplicationQuestionAndAnswerDto
    with _$EventApplicationQuestionAndAnswerDto {
  factory EventApplicationQuestionAndAnswerDto({
    required String question,
    String? answer,
    List<String>? answers,
  }) = _EventApplicationQuestionAndAnswerDto;

  factory EventApplicationQuestionAndAnswerDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$EventApplicationQuestionAndAnswerDtoFromJson(json);
}
