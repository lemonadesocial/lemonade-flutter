import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_checkin_dto.freezed.dart';
part 'event_checkin_dto.g.dart';

@freezed
class EventCheckinDto with _$EventCheckinDto {
  factory EventCheckinDto({
    @JsonKey(name: '_id') String? id,
    bool? active,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    String? event,
    String? user,
    String? email,
    @JsonKey(name: 'login_user') UserDto? loginUser,
    @JsonKey(name: 'non_login_user') UserDto? nonLoginUser,
    String? ticket,
  }) = _EventCheckinDto;

  factory EventCheckinDto.fromJson(Map<String, dynamic> json) =>
      _$EventCheckinDtoFromJson(json);
}
