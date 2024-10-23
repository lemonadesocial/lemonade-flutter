import 'package:app/core/data/event/dtos/event_checkin_dto/event_checkin_dto.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_checkin.freezed.dart';
part 'event_checkin.g.dart';

@freezed
class EventCheckin with _$EventCheckin {
  factory EventCheckin({
    String? id,
    bool? active,
    String? email,
    String? event,
    String? user,
    User? loginUser,
    User? nonLoginUser,
  }) = _EventCheckin;

  factory EventCheckin.fromJson(Map<String, dynamic> json) =>
      _$EventCheckinFromJson(json);

  factory EventCheckin.fromDto(EventCheckinDto dto) => EventCheckin(
        id: dto.id,
        active: dto.active,
        email: dto.email,
        event: dto.event,
        user: dto.user,
        loginUser: dto.loginUser != null ? User.fromDto(dto.loginUser!) : null,
        nonLoginUser:
            dto.nonLoginUser != null ? User.fromDto(dto.nonLoginUser!) : null,
      );
}
