import 'package:app/core/data/event/dtos/event_guest_user_dto/event_guest_user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_guest_user.freezed.dart';
part 'event_guest_user.g.dart';

@freezed
class EventGuestUser with _$EventGuestUser {
  factory EventGuestUser({
    String? id,
    String? name,
    String? email,
    String? imageAvatar,
  }) = _EventGuestUser;

  factory EventGuestUser.fromDto(EventGuestUserDto dto) => EventGuestUser(
        id: dto.id,
        name: dto.name,
        email: dto.email,
        imageAvatar: dto.imageAvatar,
      );

  factory EventGuestUser.fromJson(Map<String, dynamic> json) =>
      _$EventGuestUserFromJson(json);
}
