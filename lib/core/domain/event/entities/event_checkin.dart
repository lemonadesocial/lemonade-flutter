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
}
