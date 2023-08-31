import 'package:app/core/data/notification/dtos/notification_dtos.dart';
import 'package:app/core/domain/user/entities/user.dart';

class Notification {

  Notification({
    this.id, 
    this.fromExpanded, 
    this.message, 
    this.type, 
    this.createdAt,
    this.from,
    this.isSeen,
  });
  final String? id;
  User? fromExpanded;
  String? message;
  String? type;
  DateTime? createdAt;
  String? from;
  bool? isSeen;

  static Notification fromDto(NotificationDto dto) {
    return Notification(
      id: dto.id,
      fromExpanded: dto.fromExpanded != null ? User.fromDto(dto.fromExpanded!) : null,
      message: dto.message,
      type: dto.type,
      createdAt: dto.createdAt,
      from: dto.from,
      isSeen: dto.isSeen,
    );
  }
}
