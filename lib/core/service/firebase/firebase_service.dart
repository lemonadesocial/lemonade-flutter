import 'package:app/core/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../firebase_options_staging.dart' as FirebaseOptionsStaging;
import '../../../firebase_options_production.dart' as FirebaseOptionsProduction;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification title: ${message.notification?.title}');
    print('Message notification body: ${message.notification?.body}');
  }
}

class FirebaseService {
  final _messageStreamController = BehaviorSubject<RemoteMessage>();

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: AppConfig.env == 'production'
          ? FirebaseOptionsProduction.DefaultFirebaseOptions.currentPlatform
          : FirebaseOptionsStaging.DefaultFirebaseOptions.currentPlatform,
    );
    await _requestPermission();
    _setUpMessageHandlers();
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
    final messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();
    if (kDebugMode) {
      print('Registration Token: $token');
    }
    return token;
  }

  void _setUpMessageHandlers() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification title: ${message.notification?.title}');
        print('Message notification body: ${message.notification?.body}');
      }
      _messageStreamController.sink.add(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Stream<RemoteMessage> get messageStream => _messageStreamController.stream;

  void dispose() {
    _messageStreamController.close();
  }
}
