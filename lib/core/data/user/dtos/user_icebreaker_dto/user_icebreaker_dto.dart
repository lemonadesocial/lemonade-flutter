import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_icebreaker_dto.freezed.dart';
part 'user_icebreaker_dto.g.dart';

@freezed
class UserIcebreakerDto with _$UserIcebreakerDto {
  factory UserIcebreakerDto({
    @JsonKey(name: '_id') String? id,
    String? question,
    String? value,
    @JsonKey(name: 'question_expanded')
    UserIcebreakerQuestionDto? questionExpanded,
  }) = _UserIcebreakerDto;

  factory UserIcebreakerDto.fromJson(Map<String, dynamic> json) =>
      _$UserIcebreakerDtoFromJson(json);
}

@freezed
class UserIcebreakerQuestionDto with _$UserIcebreakerQuestionDto {
  factory UserIcebreakerQuestionDto({
    @JsonKey(name: '_id') String? id,
    String? title,
    String? description,
  }) = _UserIcebreakerQuestionDto;

  factory UserIcebreakerQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$UserIcebreakerQuestionDtoFromJson(json);
}
