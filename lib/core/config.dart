import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static get oauth2BaseUrl => dotenv.env['OAUTH2_BASE_URL'];
  static get oauth2ClientId => dotenv.env['OAUTH2_CLIENT_ID'];
  static get oauthRedirectScheme => 'lemonadesocial';
  static get webUrl => dotenv.env['WEB_URL'];
  static get twitterUrl => 'https://twitter.com';
  static get instagramUrl => 'https://www.instagram.com';
  static get facebookUrl => 'https://www.facebook.com';
  static get linkedinUrl => 'https://www.linkedin.com/in';
}