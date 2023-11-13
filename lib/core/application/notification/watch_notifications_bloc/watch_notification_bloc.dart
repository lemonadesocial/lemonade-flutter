import 'dart:async';

import 'package:app/core/domain/notification/entities/notification.dart';
import 'package:app/core/domain/notification/notification_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watch_notification_bloc.freezed.dart';

class WatchNotificationsBloc
    extends Bloc<WatchNotificationsEvent, WatchNotificationsState> {
  StreamSubscription? _notificationSubscription;
  final _notificationRepository = getIt<NotificationRepository>();

  WatchNotificationsBloc() : super(WatchNotificationsState.idle()) {
    _notificationSubscription =
        _notificationRepository.watchNotifications().listen(
      (event) {
        event.fold((failure) => null, (notification) {
          add(
            WatchNotificationsEvent.notificationReceived(
              notification: notification,
            ),
          );
        });
      },
    );
    on<WatchNotificationsEventNotificationReceived>(_onNotificationReceived);
  }

  @override
  Future<void> close() async {
    await _notificationSubscription?.cancel();
    return super.close();
  }

  void _onNotificationReceived(
    WatchNotificationsEventNotificationReceived event,
    Emitter emit,
  ) {
    emit(
      WatchNotificationsState.hasNewNotification(
        notification: event.notification,
      ),
    );
  }
}

@freezed
class WatchNotificationsEvent with _$WatchNotificationsEvent {
  factory WatchNotificationsEvent.notificationReceived({
    required Notification notification,
  }) = WatchNotificationsEventNotificationReceived;
}

@freezed
class WatchNotificationsState with _$WatchNotificationsState {
  factory WatchNotificationsState.idle() = WatchNotificationsIdle;
  factory WatchNotificationsState.hasNewNotification({
    required Notification notification,
  }) = WatchNotificationsHasNewNotification;
}
