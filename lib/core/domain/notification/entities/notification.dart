import 'package:app/core/data/notification/dtos/notification_dtos.dart';
import 'package:app/core/domain/user/entities/user.dart';

class Notification {
  final String? id;
  User? fromExpanded;
  String? message;
  String? type;
  DateTime? createdAt;
  String? from;
  bool? isSeen;
  String? refEvent;
  String? refRoom;
  String? refStoreOrder;
  String? refUser;
  Map<String, dynamic>? data;

  Notification({
    this.id,
    this.fromExpanded,
    this.message,
    this.type,
    this.createdAt,
    this.from,
    this.isSeen,
    this.refEvent,
    this.refRoom,
    this.refStoreOrder,
    this.refUser,
    this.data,
  });

  static Notification fromDto(NotificationDto dto) {
    return Notification(
      id: dto.id,
      fromExpanded:
          dto.fromExpanded != null ? User.fromDto(dto.fromExpanded!) : null,
      message: dto.message,
      type: dto.type,
      createdAt: dto.createdAt,
      from: dto.from,
      isSeen: dto.isSeen,
      refEvent: dto.refEvent,
      refRoom: dto.refRoom,
      refStoreOrder: dto.refStoreOrder,
      refUser: dto.refUser,
      data: dto.data,
    );
  }
}
