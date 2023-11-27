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
    String? title,
    String? message,
    String? type,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    String? from,
    @JsonKey(name: 'is_seen') bool? isSeen,
    @JsonKey(name: 'ref_event') String? refEvent,
    @JsonKey(name: 'ref_room') String? refRoom,
    @JsonKey(name: 'ref_store_order') String? refStoreOrder,
    @JsonKey(name: 'ref_user') String? refUser,
    Map<String, dynamic>? data,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}
