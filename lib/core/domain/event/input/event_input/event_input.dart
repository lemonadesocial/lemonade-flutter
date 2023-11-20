import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_input.freezed.dart';
part 'event_input.g.dart';

@freezed
class EventInput with _$EventInput {
  @JsonSerializable(includeIfNull: false)
  factory EventInput({
    required String title,
    required String description,
    required bool private,
    required bool verify,
    required String start,
    required String end,
    required String timezone,
    @JsonKey(name: 'guest_limit') required int guestLimit,
    @JsonKey(name: 'guest_limit_per') required int guestLimitPer,
    required bool virtual,
  }) = _EventInput;

  factory EventInput.fromJson(Map<String, dynamic> json) =>
      _$EventInputFromJson(json);
}
