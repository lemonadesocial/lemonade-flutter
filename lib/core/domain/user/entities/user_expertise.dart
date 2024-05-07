import 'package:app/core/data/user/dtos/user_expertise_dto/user_expertise_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_expertise.freezed.dart';
part 'user_expertise.g.dart';

@freezed
class UserExpertise with _$UserExpertise {
  const UserExpertise._();

  factory UserExpertise({
    String? id,
    String? title,
  }) = _UserExpertise;

  factory UserExpertise.fromDto(UserExpertiseDto dto) => UserExpertise(
        id: dto.id,
        title: dto.title,
      );

  factory UserExpertise.fromJson(Map<String, dynamic> json) =>
      _$UserExpertiseFromJson(json);
}
