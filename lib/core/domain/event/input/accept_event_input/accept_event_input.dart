import 'package:freezed_annotation/freezed_annotation.dart';

part 'accept_event_input.freezed.dart';
part 'accept_event_input.g.dart';

@freezed
class AcceptEventInput with _$AcceptEventInput {
  @JsonSerializable(includeIfNull: false)
  factory AcceptEventInput({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'skip_payment', defaultValue: true) bool? skipPayment,
  }) = _AcceptEventInput;

  factory AcceptEventInput.fromJson(Map<String, dynamic> json) =>
      _$AcceptEventInputFromJson(json);
}
