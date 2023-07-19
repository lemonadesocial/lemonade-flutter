import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_dtos.freezed.dart';
part 'notification_dtos.g.dart';

@freezed
class NotificationDto with _$NotificationDto {
  @JsonSerializable(explicitToJson: true)
  factory NotificationDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'from_expanded') UserDto? fromExpanded,
    
    String? message,
    String? type,
    DateTime? stamp,
    String? from,
    bool? seen,
    String? object_id,
    String? object_type,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) => _$NotificationDtoFromJson(json);
}