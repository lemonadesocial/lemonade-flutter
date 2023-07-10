import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_dtos.freezed.dart';
part 'notification_dtos.g.dart';

@freezed
class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    required String id,
    required String message,
    required String type,
    // Add other properties as needed
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}