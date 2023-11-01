import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/core/config.dart';
import 'package:app/core/data/fcm/fcm_mutation.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:matrix/matrix.dart';

import 'package:app/firebase_options_production.dart'
    as firebase_options_production;
import 'package:app/firebase_options_staging.dart' as firebase_options_staging;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Handling a background message: ${message.messageId}');
    print('Message data: ${message.data}');
    print('Message notification title: ${message.notification?.title}');
    print('Message notification body: ${message.notification?.body}');
  }
}

@lazySingleton
class FirebaseService {
  // ignore: unused_field
  static AppRouter? _router;
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  late AndroidNotificationChannel channel;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: AppConfig.isProduction
            ? firebase_options_production.DefaultFirebaseOptions.currentPlatform
            : firebase_options_staging.DefaultFirebaseOptions.currentPlatform,
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

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(),
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
          if (kDebugMode) {
            print('onDidReceiveNotificationResponse');
          }
          try {
            // TODO: Handle notification navigate
            // var jsonObject = json.decode(notificationResponse.payload ?? '');
            // String type = jsonObject['type'];
            // String objectId = jsonObject['object_id'];
            // String objectType = jsonObject['object_type'];

            // NavigationUtils.handleNotificationNavigate(
            //     _router!, _context!, type, objectType, objectId);
          } catch (e) {
            if (kDebugMode) {
              print('Error parsing JSON: $e');
            }
          }
        },
      );
      FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(kDebugMode == false);
      FlutterError.onError = (errorDetails) {
        /// Bypass [ArgumentError]
        if (errorDetails.exception is ArgumentError) return;
        if (errorDetails.exception is HttpException) {
          final error = errorDetails.exception as HttpException;
          final statusCode =
              int.parse(error.message.substring(error.message.length - 3));

          /// Bypass statusCode 404
          if (statusCode == 404) return;
        }
        // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      PlatformDispatcher.instance.onError = (error, stack) {
        // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      _setUpMessageHandlers();
      getIt<AppOauth>().tokenStateStream.listen(_onTokenStateChange);
      getToken();
    } catch (e) {
      if (kDebugMode) {
        print("error firebase initialize : ${e.toString()}");
      }
    }
  }

  void setupContextAndRouter({
    required AppRouter router,
    required BuildContext context,
  }) {
    _router = router;
  }

  Future<void> requestPermission() async {
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
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) {
        print('Registration Token: $token');
      }
      return token;
    } catch (e) {
      if (kDebugMode) {
        print('error getToken : ${e.toString()}');
      }
    }
    return null;
  }

  showFlutterNotification(RemoteMessage message) async {
    Logs().i("showFlutterNotification");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: json.encode(message.data),
      );
    }
  }

  void _setUpMessageHandlers() {
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(onPressNotification);
  }

  void onPressNotification(RemoteMessage message) {
    if (kDebugMode) {
      print('onPressNotification: ${message.data}');
    }
    try {
      // var jsonObject = message.data;
      // String type = jsonObject['type'];
      // String objectId = jsonObject['object_id'];
      // String objectType = jsonObject['object_type'];

      // NavigationUtils.handleNotificationNavigate(
      //     _router!, _context!, type, objectType, objectId);
    } catch (e) {
      if (kDebugMode) {
        print('Something wrong when onPressNotification: $e');
      }
    }
  }

  void addFcmToken() async {
    String? fcmToken = await getToken();
    if (fcmToken == null || fcmToken == '') {
      return;
    }
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
    if (fcmToken == null || fcmToken == '') {
      return;
    }
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
}
