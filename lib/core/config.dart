import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static get env => dotenv.env['ENV'];
  static get oauth2BaseUrl => dotenv.env['OAUTH2_BASE_URL'];
  static get oauth2ClientId => dotenv.env['OAUTH2_CLIENT_ID'];
  static get oauthRedirectScheme => 'lemonadesocial';
  static get firebaseVapidKey => dotenv.env['FIREBASE_VAPID_KEY'];
}