import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_guest_user_dto.freezed.dart';
part 'event_guest_user_dto.g.dart';

@freezed
class EventGuestUserDto with _$EventGuestUserDto {
  factory EventGuestUserDto({
    @JsonKey(name: '_id') String? id,
    String? name,
    String? email,
    @JsonKey(name: 'image_avatar') String? imageAvatar,
  }) = _EventGuestUserDto;

  factory EventGuestUserDto.fromJson(Map<String, dynamic> json) =>
      _$EventGuestUserDtoFromJson(json);
}
