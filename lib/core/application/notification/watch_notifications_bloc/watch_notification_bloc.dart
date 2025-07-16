import 'dart:async';

import 'package:app/core/domain/notification/entities/notification.dart';
import 'package:app/core/domain/notification/notification_repository.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/auth_method_tracker/auth_method_tracker.dart';
import 'package:app/core/service/ory_auth/ory_auth.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watch_notification_bloc.freezed.dart';

class WatchNotificationsBloc
    extends Bloc<WatchNotificationsEvent, WatchNotificationsState> {
  StreamSubscription? _notificationSubscription;
  StreamSubscription? _authSubscription;
  final _notificationRepository = getIt<NotificationRepository>();

  WatchNotificationsBloc() : super(WatchNotificationsState.idle()) {
    init();
    on<WatchNotificationsEventNotificationReceived>(_onNotificationReceived);
  }

  Future<void> init() async {
    final authMethod = await getIt<AuthMethodTracker>().getAuthMethod();
    _authSubscription = authMethod == AuthMethod.oauth
        ? getIt<AppOauth>().tokenStateStream.listen(
            (event) async {
              if (event == OAuthTokenState.invalid) {
                _notificationSubscription?.cancel();
                _notificationSubscription = null;
              }

              if (event == OAuthTokenState.valid) {
                await _startNotificationSubscription();
              }
            },
          )
        : getIt<OryAuth>().orySessionStateStream.listen(
            (event) async {
              if (event == OrySessionState.invalid) {
                _notificationSubscription?.cancel();
                _notificationSubscription = null;
              }

              if (event == OrySessionState.valid) {
                await _startNotificationSubscription();
              }
            },
          );
  }

  @override
  Future<void> close() async {
    await _notificationSubscription?.cancel();
    await _authSubscription?.cancel();
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

  Future<void> _startNotificationSubscription() async {
    if (_notificationSubscription != null) {
      await _notificationSubscription
          ?.cancel()
          .catchError((e) => _notificationSubscription = null);
      _notificationSubscription = null;
    }
    _notificationSubscription =
        _notificationRepository.watchNotifications().listen((event) {
      event.fold((failure) => null, (notification) {
        add(
          WatchNotificationsEvent.notificationReceived(
            notification: notification,
          ),
        );
      });
    });
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
