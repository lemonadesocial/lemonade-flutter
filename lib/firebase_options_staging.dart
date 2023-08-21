// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_staging.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBQJDQauzQ8L3vA0HaoXyMHxjAfTaxVHfk',
    appId: '1:610594530625:web:4846ab413bc943b997adc0',
    messagingSenderId: '610594530625',
    projectId: 'lemonade-staging-88d1c',
    authDomain: 'lemonade-staging-88d1c.firebaseapp.com',
    storageBucket: 'lemonade-staging-88d1c.appspot.com',
    measurementId: 'G-CJ2PDGK7DV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAa6SbBX30d2xsl-opo_jvavt22cj3wN2Y',
    appId: '1:610594530625:android:0f12542abff71d4197adc0',
    messagingSenderId: '610594530625',
    projectId: 'lemonade-staging-88d1c',
    storageBucket: 'lemonade-staging-88d1c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzBUA3AK8aCgfzPYHRlMlbC-2t3ddmO9k',
    appId: '1:610594530625:ios:f5524cdc2292c7c497adc0',
    messagingSenderId: '610594530625',
    projectId: 'lemonade-staging-88d1c',
    storageBucket: 'lemonade-staging-88d1c.appspot.com',
    iosBundleId: 'social.lemonade.app.staging',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzBUA3AK8aCgfzPYHRlMlbC-2t3ddmO9k',
    appId: '1:610594530625:ios:1a6c5dfa33638d0c97adc0',
    messagingSenderId: '610594530625',
    projectId: 'lemonade-staging-88d1c',
    storageBucket: 'lemonade-staging-88d1c.appspot.com',
    iosBundleId: 'com.lemonadesocial.app.RunnerTests',
  );
}
