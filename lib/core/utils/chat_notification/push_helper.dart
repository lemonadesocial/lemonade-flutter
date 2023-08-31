import 'dart:convert';
import 'dart:io';

import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat_notification/setting_keys.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:matrix/matrix.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> pushHelper(
  PushNotification notification, {
  Client? client,
  void Function(NotificationResponse?)? onSelectNotification,
}) async {
  try {
    await _tryPushHelper(
      notification,
      client: client,
      onSelectNotification: onSelectNotification,
    );
  } catch (e, s) {
    Logs().wtf('Push Helper has crashed!', e, s);

    // Initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: onSelectNotification,
    );

    flutterLocalNotificationsPlugin.show(
      0,
      "newMessageInLemonadeChat",
      "openAppToReadMessages",
      NotificationDetails(
        iOS: const DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          "lemonadechat_push",
          "LemonadeChat push channel",
          channelDescription: 'Push notifications for LemonadeChat',
          number: notification.counts?.unread,
          ticker: "Unread chats",
          // ticker: t.chat.unread_chats(unreadCount: notification.counts?.unread ?? 1),
          importance: Importance.max,
          priority: Priority.max,
        ),
      ),
    );
    rethrow;
  }
}

Future<void> _tryPushHelper(
  PushNotification notification, {
  Client? client,
  void Function(NotificationResponse?)? onSelectNotification,
}) async {
  Logs().v('_tryPushHelper');
  final isBackgroundMessage = client == null;
  Logs().v(
    'Push helper has been started (background=$isBackgroundMessage).',
    notification.toJson(),
  );

  // TOOD: Keep this due to maybe we wanna block push in forreground
  // if (!isBackgroundMessage &&
  //     client.syncPresence == null) {
  //   Logs().v('Room is in foreground. Stop push helper here.');
  //   return;
  // }

  // Initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: onSelectNotification,
    //onDidReceiveBackgroundNotificationResponse: onSelectNotification,
  );

  client = getIt<MatrixService>().client;
  final event = await client.getEventByPushNotification(
    notification,
    storeInDatabase: isBackgroundMessage,
  );

  if (event == null) {
    Logs().v('Notification is a clearing indicator.');
    if (notification.counts?.unread == 0) {
      if (notification.counts == null || notification.counts?.unread == 0) {
        await flutterLocalNotificationsPlugin.cancelAll();
        final store = await SharedPreferences.getInstance();
        await store.setString(
          'chat.lemonade.notification_ids',
          json.encode({}),
        );
      }
    }
    return;
  }
  Logs().v('Push helper got notification event of type ${event.type}.');

  if (event.type.startsWith('m.call')) {
    // make sure bg sync is on (needed to update hold, unhold events)
    // prevent over write from app life cycle change
    client.backgroundSync = true;
  }

  if (event.type == EventTypes.CallInvite) {
    // TODO: Implement phone call
    // CallKeepManager().initialize();
  } else if (event.type == EventTypes.CallHangup) {
    client.backgroundSync = false;
  }

  if (event.type.startsWith('m.call') && event.type != EventTypes.CallInvite) {
    Logs().v('Push message is a m.call but not invite. Do not display.');
    return;
  }

  if ((event.type.startsWith('m.call') &&
          event.type != EventTypes.CallInvite) ||
      event.type == 'org.matrix.call.sdp_stream_metadata_changed') {
    Logs().v('Push message was for a call, but not call invite.');
    return;
  }

  // Calculate the body
  final body = event.type == EventTypes.Encrypted
      ? '💬 You got a new message'
      : await event.calcLocalizedBody(
          const MatrixDefaultLocalizations(),
          plaintextBody: true,
          hideReply: true,
          hideEdit: true,
          removeMarkdown: true,
        );

  // The person object for the android message style notification
  final avatar = event.room.avatar
      ?.getThumbnail(
        client,
        width: 126,
        height: 126,
      )
      .toString();
  File? avatarFile;
  try {
    avatarFile = avatar == null
        ? null
        : await DefaultCacheManager().getSingleFile(avatar);
  } catch (e, s) {
    Logs().e('Unable to get avatar picture', e, s);
  }

  final id = await mapRoomIdToInt(event.room.id);

  // Show notification
  final person = Person(
    name: event.senderFromMemoryOrFallback.calcDisplayname(),
    icon:
        avatarFile == null ? null : BitmapFilePathAndroidIcon(avatarFile.path),
  );
  final newMessage = Message(
    body,
    event.originServerTs,
    person,
  );

  final messagingStyleInformation = Platform.isAndroid
      ? await AndroidFlutterLocalNotificationsPlugin()
          .getActiveNotificationMessagingStyle(id)
      : null;
  messagingStyleInformation?.messages?.add(newMessage);

  final roomName =
      event.room.getLocalizedDisplayname(const MatrixDefaultLocalizations());

  final notificationGroupId =
      event.room.isDirectChat ? 'directChats' : 'groupChats';
  final groupName = event.room.isDirectChat ? "Direct chat" : "Group";

  final messageRooms = AndroidNotificationChannelGroup(
    notificationGroupId,
    groupName,
  );
  final roomsChannel = AndroidNotificationChannel(
    event.room.id,
    roomName,
    groupId: notificationGroupId,
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannelGroup(messageRooms);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(roomsChannel);

  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    event.room.id,
    roomName,
    channelDescription: groupName,
    number: notification.counts?.unread,
    category: AndroidNotificationCategory.message,
    styleInformation: messagingStyleInformation ??
        MessagingStyleInformation(
          person,
          conversationTitle: roomName,
          groupConversation: !event.room.isDirectChat,
          messages: [newMessage],
        ),
    ticker: 'Unread chats',
    // ticker: t.chat.unread_chats(unreadCount: notification.counts?.unread ?? 1),
    importance: Importance.max,
    priority: Priority.max,
    groupKey: notificationGroupId,
  );
  const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
  final platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  final title = roomName;
  Logs().i('title: $title', title);
  Logs().i('body: $body', body);
  await flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    platformChannelSpecifics,
    payload: event.roomId,
  );
  Logs().v('Push helper has been completed!');
}

/// Workaround for the problem that local notification IDs must be int but we
/// sort by [roomId] which is a String. To make sure that we don't have duplicated
/// IDs we map the [roomId] to a number and store this number.
Future<int> mapRoomIdToInt(String roomId) async {
  final store = await SharedPreferences.getInstance();
  final idMap = Map<String, int>.from(
    jsonDecode(store.getString(SettingKeys.notificationCurrentIds) ?? '{}'),
  );
  int? currentInt;
  try {
    currentInt = idMap[roomId];
  } catch (_) {
    currentInt = null;
  }
  if (currentInt != null) {
    return currentInt;
  }
  var nCurrentInt = 0;
  while (idMap.values.contains(nCurrentInt)) {
    nCurrentInt++;
  }
  idMap[roomId] = nCurrentInt;
  await store.setString(SettingKeys.notificationCurrentIds, json.encode(idMap));
  return nCurrentInt;
}
