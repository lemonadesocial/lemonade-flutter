import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_frequent_question_dto.freezed.dart';
part 'event_frequent_question_dto.g.dart';

@freezed
class EventFrequentQuestionDto with _$EventFrequentQuestionDto {
  factory EventFrequentQuestionDto({
    @JsonKey(name: '_id') String? id,
  }) = _EventFrequentQuestionDto;

  factory EventFrequentQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$EventFrequentQuestionDtoFromJson(json);
}
