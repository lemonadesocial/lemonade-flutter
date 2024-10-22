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
    String? event,
    String? user,
    User? userExpanded,
  }) = _EventCheckin;

  factory EventCheckin.fromJson(Map<String, dynamic> json) =>
      _$EventCheckinFromJson(json);

  factory EventCheckin.fromDto(EventCheckinDto dto) => EventCheckin(
        id: dto.id,
        active: dto.active,
        event: dto.event,
        user: dto.user,
        userExpanded:
            dto.userExpanded != null ? User.fromDto(dto.userExpanded!) : null,
      );
}
