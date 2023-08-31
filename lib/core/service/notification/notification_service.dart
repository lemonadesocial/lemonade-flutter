import 'package:app/core/domain/notification/entities/notification.dart';
import 'package:app/core/domain/notification/notification_repository.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

class NotificationService {
  NotificationService(this.notificationRepository);
  final NotificationRepository notificationRepository;

  Future<Either<Failure, List<Notification>>> getNotifications() async {
    return await notificationRepository.getNotifications();
  }
}
