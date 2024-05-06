import 'package:app/core/data/user/dtos/user_icebreaker_dto/user_icebreaker_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_icebreaker.freezed.dart';
part 'user_icebreaker.g.dart';

@freezed
class UserIcebreaker with _$UserIcebreaker {
  const UserIcebreaker._();

  factory UserIcebreaker({
    String? id,
    String? question,
    String? value,
    UserIcebreakerQuestion? questionExpanded,
  }) = _UserIcebreaker;

  factory UserIcebreaker.fromDto(UserIcebreakerDto dto) => UserIcebreaker(
        id: dto.id,
        question: dto.question,
        value: dto.value,
        questionExpanded: dto.questionExpanded != null
            ? UserIcebreakerQuestion.fromDto(dto.questionExpanded!)
            : null,
      );

  factory UserIcebreaker.fromJson(Map<String, dynamic> json) =>
      _$UserIcebreakerFromJson(json);
}

@freezed
class UserIcebreakerQuestion with _$UserIcebreakerQuestion {
  const UserIcebreakerQuestion._();

  factory UserIcebreakerQuestion({
    String? id,
    String? title,
    String? description,
  }) = _UserIcebreakerQuestion;

  factory UserIcebreakerQuestion.fromDto(UserIcebreakerQuestionDto dto) =>
      UserIcebreakerQuestion(
        id: dto.id,
        title: dto.title,
        description: dto.description,
      );

  factory UserIcebreakerQuestion.fromJson(Map<String, dynamic> json) =>
      _$UserIcebreakerQuestionFromJson(json);
}
