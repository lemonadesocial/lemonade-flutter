import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_follow_dtos.freezed.dart';

part 'user_follow_dtos.g.dart';

@freezed
class UserFollowDto with _$UserFollowDto {
  const factory UserFollowDto({
    String? followee,
    String? follower,
  }) = _UserFollowDto;

  factory UserFollowDto.fromJson(Map<String, dynamic> json) =>
      _$UserFollowDtoFromJson(json);
}
