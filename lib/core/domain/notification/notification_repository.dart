import 'package:app/core/domain/notification/entities/notification.dart';
import 'package:app/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<Notification>>> getNotifications();
}
