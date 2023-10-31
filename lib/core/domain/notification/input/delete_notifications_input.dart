import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_notifications_input.freezed.dart';
part 'delete_notifications_input.g.dart';

@freezed
class DeleteNotificationsInput with _$DeleteNotificationsInput {
  factory DeleteNotificationsInput({
    required List<String> ids,
  }) = _DeleteNotificationsInput;

  factory DeleteNotificationsInput.fromJson(Map<String, dynamic> json) =>
      _$DeleteNotificationsInputFromJson(json);
}
