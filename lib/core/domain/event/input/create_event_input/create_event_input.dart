import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_event_input.freezed.dart';
part 'create_event_input.g.dart';

@freezed
class CreateEventInput with _$CreateEventInput {
  @JsonSerializable(includeIfNull: false)
  factory CreateEventInput({
    required String title,
    required String description,
    required bool private,
    required bool verify,
    required DateTime start,
    required DateTime end,
    required String timezone,
    @JsonKey(name: 'guest_limit') required int guestLimit,
    @JsonKey(name: 'guest_limit_per') required int guestLimitPer,
    required bool virtual,
  }) = _CreateEventInput;

  factory CreateEventInput.fromJson(Map<String, dynamic> json) =>
      _$CreateEventInputFromJson(json);
}
