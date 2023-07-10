import 'package:app/core/data/notification/dtos/notification_dtos.dart';

class Notification {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  Notification({this.id, this.firstName, this.lastName, this.email});

  static Notification fromDto(NotificationDto dto) {
    return Notification(
      id: dto.id,
      firstName: dto.message,
      lastName: dto.type,
    );
  }
}
