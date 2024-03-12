import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application_question.freezed.dart';
part 'event_application_question.g.dart';

@freezed
class EventApplicationQuestion with _$EventApplicationQuestion {
  factory EventApplicationQuestion({
    String? id,
    String? question,
    String? event,
  }) = _EventApplicationQuestion;

  factory EventApplicationQuestion.fromJson(Map<String, dynamic> json) =>
      _$EventApplicationQuestionFromJson(json);
}
