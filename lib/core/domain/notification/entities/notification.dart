import 'package:app/core/data/notification/dtos/notification_dtos.dart';
import 'package:app/core/domain/user/entities/user.dart';

class Notification {
  final String? id;
  User? fromExpanded;
  String? message;
  String? type;
  DateTime? stamp;
  String? from;
  bool? seen;
  String? object_id;
  String? object_type;

  Notification({
    this.id, 
    this.fromExpanded, 
    this.message, 
    this.type, 
    this.stamp,
    this.from,
    this.seen,
    this.object_id,
    this.object_type
  });

  static Notification fromDto(NotificationDto dto) {
    return Notification(
      id: dto.id,
      fromExpanded: dto.fromExpanded != null ? User.fromDto(dto.fromExpanded!) : null,
      message: dto.message,
      type: dto.type,
      stamp: dto.stamp,
      from: dto.from,
      seen: dto.seen,
      object_id: dto.object_id,
      object_type: dto.object_type
    );
  }
}
