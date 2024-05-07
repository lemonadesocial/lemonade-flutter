import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_expertise_dto.freezed.dart';
part 'user_expertise_dto.g.dart';

@freezed
class UserExpertiseDto with _$UserExpertiseDto {
  factory UserExpertiseDto({
    @JsonKey(name: '_id') String? id,
    String? title,
  }) = _UserExpertiseDto;

  factory UserExpertiseDto.fromJson(Map<String, dynamic> json) =>
      _$UserExpertiseDtoFromJson(json);
}
