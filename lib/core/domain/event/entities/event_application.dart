import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_application.freezed.dart';
part 'event_application.g.dart';

@freezed
class EventApplicationQuestion with _$EventApplicationQuestion {
  factory EventApplicationQuestion({
    @JsonKey(name: '_id') String? id,
    String? question,
  }) = _EventApplicationQuestion;

  factory EventApplicationQuestion.fromJson(Map<String, dynamic> json) =>
      _$EventApplicationQuestionFromJson(json);
}

@freezed
class EventApplicationAnswer with _$EventApplicationAnswer {
  @JsonSerializable(explicitToJson: true)
  factory EventApplicationAnswer({
    @JsonKey(name: '_id') String? id,
    String? answer,
    String? question,
    String? user,
    @JsonKey(name: 'question_expanded')
    EventApplicationQuestion? questionExpanded,
  }) = _EventApplicationAnswer;

  factory EventApplicationAnswer.fromJson(Map<String, dynamic> json) =>
      _$EventApplicationAnswerFromJson(json);
}
