import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/core/config.dart';
import 'package:app/core/data/fcm/fcm_mutation.dart';
import 'package:app/core/gql.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/chat_notification/push_helper.dart';
import 'package:app/core/utils/navigation_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../firebase_options_staging.dart' as FirebaseOptionsStaging;
import '../../../firebase_options_production.dart' as FirebaseOptionsProduction;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification title: ${message.notification?.title}');
    print('Message notification body: ${message.notification?.body}');
  }
  try {
    // final client = getIt<MatrixService>().client;
    // String? type = message.data['type'];
    // String? objectType = message.data['object_type'];
    // String? objectId = message.data['object_id'];
    // NavigationUtils.handleNotificationNavigate(
    //     FirebaseService._context!, type, objectType, objectId);
  } catch (e) {
    print("Something wrong _firebaseMessagingBackgroundHandler $e");
  }
}

@lazySingleton
class FirebaseService {
  static Client? _client;
  static BuildContext? _context;
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  late AndroidNotificationChannel channel;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void setContext(BuildContext context) => FirebaseService._context = context;
  void setClient(Client client) => FirebaseService._client = client;

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: AppConfig.env == 'production'
          ? FirebaseOptionsProduction.DefaultFirebaseOptions.currentPlatform
          : FirebaseOptionsStaging.DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        try {
          var jsonObject = json.decode(notificationResponse.payload ?? "");
          String type = jsonObject['type'];
          String objectId = jsonObject['object_id'];
          String objectType = jsonObject['object_type'];
          NavigationUtils.handleNotificationNavigate(
              _context!, type, objectType, objectId);
        } catch (e) {
          print("Error parsing JSON: $e");
        }
      },
    );
    FlutterError.onError = (errorDetails) {
      // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    await _requestPermission();
    // _setUpMessageHandlers();
    getIt<AppOauth>().tokenStateStream.listen(_onTokenStateChange);
    getToken();
  }

  Future<void> _requestPermission() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }
  }

  Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print('Registration Token: $token');
    }
    return token;
  }

  showFlutterNotification(RemoteMessage message) async {
    Logs().i("showFlutterNotification");
    final client = getIt<MatrixService>().client;
    final data = message.data;
    data['devices'] ??= [];
    await _tryPushHelper(
      PushNotification.fromJson(data),
      client: client,
    );
    // RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification?.android;
    // if (notification != null && android != null && !kIsWeb) {
    //   flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           channelDescription: channel.description,
    //           icon: '@mipmap/ic_launcher',
    //         ),
    //       ),
    //       payload: json.encode(message.data));
    // }
  }

  void _setUpMessageHandlers() {
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp
        .listen(_firebaseMessagingBackgroundHandler);
  }

  void addFcmToken() async {
    String? fcmToken = await getToken();
    await getIt<AppGQL>().client.mutate(
          MutationOptions(
            document: addUserFcmTokenMutation,
            variables: {
              'token': fcmToken,
            },
            parserFn: (data) => data['addFcmToken'],
          ),
        );
  }

  Future<void> removeFcmToken() async {
    String? fcmToken = await getToken();
    final response = await getIt<AppGQL>().client.mutate(
          MutationOptions(
            document: removeUserFcmTokenMutation,
            variables: {
              'token': fcmToken,
            },
            parserFn: (data) => data['removeFcmToken'],
          ),
        );
    if (!response.hasException) {
      _firebaseMessaging?.deleteToken();
    }
  }

  void _onTokenStateChange(OAuthTokenState tokenState) {
    if (tokenState == OAuthTokenState.valid) {
      addFcmToken();
    } else if (tokenState == OAuthTokenState.invalid) {
      if (_firebaseMessaging != null) {
        _firebaseMessaging?.deleteToken();
      }
    }
  }

  Future<void> _tryPushHelper(
    PushNotification notification, {
    Client? client,
    String? activeRoomId,
    void Function(NotificationResponse?)? onSelectNotification,
  }) async {
    Logs().v('_tryPushHelper');
    final isBackgroundMessage = client == null;
    Logs().v(
      'Push helper has been started (background=$isBackgroundMessage).',
      notification.toJson(),
    );

    if (!isBackgroundMessage &&
        activeRoomId == notification.roomId &&
        activeRoomId != null &&
        client.syncPresence == null) {
      Logs().v('Room is in foreground. Stop push helper here.');
      return;
    }

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
            "chat.lemonade.notification_ids",
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

    if (event.type.startsWith('m.call') &&
        event.type != EventTypes.CallInvite) {
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
        ? "💬 You got a new message"
        : await event.calcLocalizedBody(
            MatrixDefaultLocalizations(),
            plaintextBody: true,
            withSenderNamePrefix: false,
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
      icon: avatarFile == null
          ? null
          : BitmapFilePathAndroidIcon(avatarFile.path),
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
        event.room.getLocalizedDisplayname(MatrixDefaultLocalizations());

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
      ticker: "Unread chats",
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

    await flutterLocalNotificationsPlugin.show(
      id,
      event.room.getLocalizedDisplayname(MatrixDefaultLocalizations()),
      body,
      platformChannelSpecifics,
      payload: event.roomId,
    );
    Logs().v('Push helper has been completed!');
  }
}
