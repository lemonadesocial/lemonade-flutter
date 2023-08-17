import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/core/config.dart';
import 'package:app/core/utils/chat_notification/setting_keys.dart';
import 'package:app/core/utils/platform_infos.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fcm_shared_isolate/fcm_shared_isolate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:matrix/matrix.dart';

import 'famedlysdk_store.dart';
import 'push_helper.dart';


class BackgroundPush {

  BackgroundPush(this.client) {
    onRoomSync ??= client.onSync.stream
        .where((s) => s.hasRoomUpdate)
        .listen((s) => _onClearingPush(getFromServer: false));
    firebase?.setListeners(
      onMessage: onMessage,
    );
  }
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final Client client;
  String? _fcmToken;
  BuildContext? _context;
  AppRouter? _router;
  final dynamic firebase = FcmSharedIsolate();
  StreamSubscription<SyncUpdate>? onRoomSync;
  bool upAction = false;
  Store? _store;
  Store get store => _store ??= Store();

  void setupContextAndRouter({
    required AppRouter router,
    required BuildContext context,
  }) {
    _router = router;
    _context = context;
  }

  Future<void> onMessage(Map<dynamic, dynamic> message) async {
    if (kDebugMode) {
      print('Got a new message from firebase cloud messaging: $message');
    }
    final data = Map<String, dynamic>.from(message);
    // UP may strip the devices list
    data['devices'] ??= [];
    pushHelper(
      PushNotification.fromJson(
        Map<String, dynamic>.from(data),
      ),
      client: client,
      onSelectNotification: goToRoom,
    );
  }

  bool _clearingPushLock = false;
  Future<void> _onClearingPush({bool getFromServer = true}) async {
    if (_clearingPushLock) {
      return;
    }
    try {
      _clearingPushLock = true;
      late Iterable<String> emptyRooms;
      if (getFromServer) {
        Logs().v('[Push] Got new clearing push');
        var syncErrored = false;
        if (client.syncPending) {
          Logs().v('[Push] waiting for existing sync');
          // we need to catchError here as the Future might be in a different execution zone
          await client.oneShotSync().catchError((e) {
            syncErrored = true;
            Logs().v('[Push] Error one-shot syncing', e);
          });
        }
        if (!syncErrored) {
          Logs().v('[Push] single oneShotSync');
          // we need to catchError here as the Future might be in a different execution zone
          await client.oneShotSync().catchError((e) {
            syncErrored = true;
            Logs().v('[Push] Error one-shot syncing', e);
          });
          if (!syncErrored) {
            emptyRooms = client.rooms
                .where((r) => r.notificationCount == 0)
                .map((r) => r.id);
          }
        }
        if (syncErrored) {
          try {
            Logs().v(
              '[Push] failed to sync for fallback push, fetching notifications endpoint...',
            );
            final notifications = await client.getNotifications(limit: 20);
            final notificationRooms =
                notifications.notifications.map((n) => n.roomId).toSet();
            emptyRooms = client.rooms
                .where((r) => !notificationRooms.contains(r.id))
                .map((r) => r.id);
          } catch (e) {
            Logs().v(
              '[Push] failed to fetch pending notifications for clearing push, falling back...',
              e,
            );
            emptyRooms = client.rooms
                .where((r) => r.notificationCount == 0)
                .map((r) => r.id);
          }
        }
      } else {
        emptyRooms = client.rooms
            .where((r) => r.notificationCount == 0)
            .map((r) => r.id);
      }
      await _loadIdMap();
      var changed = false;
      for (final roomId in emptyRooms) {
        final id = idMap[roomId];
        if (id != null) {
          idMap.remove(roomId);
          changed = true;
          await _flutterLocalNotificationsPlugin.cancel(id);
        }
      }
      if (changed) {
        await store.setItem(
          SettingKeys.notificationCurrentIds,
          json.encode(idMap),
        );
      }
    } finally {
      _clearingPushLock = false;
    }
  }

  Future<void> goToRoom(NotificationResponse? response) async {
    try {
      final roomId = response?.payload;
      Logs().v('[Push] Attempting to go to room $roomId...');
      if (_router == null || roomId == null) {
        return;
      }
      await client.roomsLoading;
      await client.accountDataLoading;
      AutoRouter.of(_context!).navigateNamed('/chat/detail/$roomId');
    } catch (e, s) {
      Logs().e('[Push] Failed to open room', e, s);
    }
  }

  /// Workaround for the problem that local notification IDs must be int but we
  /// sort by [roomId] which is a String. To make sure that we don't have duplicated
  /// IDs we map the [roomId] to a number and store this number.
  late Map<String, int> idMap;
  Future<void> _loadIdMap() async {
    idMap = Map<String, int>.from(
      json.decode(
        (await store.getItem(SettingKeys.notificationCurrentIds)) ?? '{}',
      ),
    );
  }

  Future<void> setupPusher({
    String? gatewayUrl,
    String? token,
    Set<String?>? oldTokens,
    bool useDeviceSpecificAppId = false,
  }) async {
    if (Platform.isIOS) {
      final result = await firebase?.requestPermission();
      Logs().i('result requestPermission');
      Logs().i(result.toString());
    }
    final clientName = PlatformInfos.clientName;
    oldTokens ??= <String>{};
    final pushers = await client.getPushers().catchError((e) {
          Logs().w('[Push] Unable to request pushers', e);
          return <Pusher>[];
        }) ??
        [];

    var setNewPusher = false;
    // Just the plain app id, we add the .data_message suffix later
    var appId = AppConfig.pushNotificationsAppId;
    // we need the deviceAppId to remove potential legacy UP pusher
    var deviceAppId = '$appId.${client.deviceID}';
    // appId may only be up to 64 chars as per spec
    if (deviceAppId.length > 64) {
      deviceAppId = deviceAppId.substring(0, 64);
    }
    if (!useDeviceSpecificAppId && PlatformInfos.isAndroid) {
      appId += '.data_message';
    }
    final thisAppId = useDeviceSpecificAppId ? deviceAppId : appId;
    if (gatewayUrl != null && token != null) {
      final currentPushers = pushers.where((pusher) => pusher.pushkey == token);
      if (currentPushers.length == 1 &&
          currentPushers.first.kind == 'http' &&
          currentPushers.first.appId == thisAppId &&
          currentPushers.first.appDisplayName == clientName &&
          currentPushers.first.deviceDisplayName == client.deviceName &&
          currentPushers.first.lang == 'en' &&
          currentPushers.first.data.url.toString() == gatewayUrl &&
          currentPushers.first.data.format ==
              AppConfig.pushNotificationsPusherFormat) {
        Logs().i('[Push] Pusher already set');
        Logs().i(currentPushers.first.appId);
        Logs().i(currentPushers.first.appDisplayName);
        Logs().i(currentPushers.first.deviceDisplayName);
        Logs().i(currentPushers.first.pushkey);
        Logs().i(currentPushers.first.data.url.toString());
      } else {
        Logs().i('Need to set new pusher');
        oldTokens.add(token);
        if (client.isLogged()) {
          setNewPusher = true;
        }
      }
    } else {
      Logs().w('[Push] Missing required push credentials');
    }
    for (final pusher in pushers) {
      if ((token != null &&
              pusher.pushkey != token &&
              deviceAppId == pusher.appId) ||
          oldTokens.contains(pusher.pushkey)) {
        try {
          await client.deletePusher(pusher);
          Logs().i('[Push] Removed legacy pusher for this device');
        } catch (err) {
          Logs().w('[Push] Failed to remove old pusher', err);
        }
      }
    }
    if (setNewPusher) {
      try {
        Logs().i('[Push] postPusher');
        await client.postPusher(
          Pusher(
            pushkey: token!,
            appId: thisAppId,
            appDisplayName: clientName,
            deviceDisplayName: client.deviceName!,
            lang: 'en',
            data: PusherData(
              url: Uri.parse(gatewayUrl!),
              format: AppConfig.pushNotificationsPusherFormat,
            ),
            kind: 'http',
          ),
          append: false,
        );
      } catch (e, s) {
        Logs().e('[Push] Unable to set pushers', e, s);
      }
    }
  }

  Future<void> setupFirebase() async {
    Logs().v('Setup firebase');
    if (_fcmToken?.isEmpty ?? true) {
      try {
        _fcmToken = await firebase?.getToken();
        Logs().i('_fcmToken');
        Logs().i(_fcmToken!);
        if (_fcmToken == null) {
          // ignore: only_throw_errors
          throw 'PushToken is null';
        }
      } catch (e, s) {
        Logs().w('[Push] cannot get token', e, e is String ? null : s);
        return;
      }
    }
    await setupPusher(
      gatewayUrl: AppConfig.pushNotificationsGatewayUrl,
      token: _fcmToken,
    );
  }

  bool _wentToRoomOnStartup = false;
  Future<void> setupPush() async {
    Logs().d('SetupPush');
    if (client.onLoginStateChanged.value != LoginState.loggedIn ||
        !PlatformInfos.isMobile) {
      return;
    }
    // Do not setup unifiedpush if this has been initialized by
    // an unifiedpush action
    if (upAction) {
      return;
    }
    await setupFirebase();

    // ignore: unawaited_futures
    _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails()
        .then((details) {
      if (details == null ||
          !details.didNotificationLaunchApp ||
          _wentToRoomOnStartup) {
        return;
      }
      _wentToRoomOnStartup = true;
      goToRoom(details.notificationResponse);
    });
  }
}
