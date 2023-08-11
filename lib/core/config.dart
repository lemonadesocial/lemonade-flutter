import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static get env => dotenv.env['ENV'];
  static get oauth2BaseUrl => dotenv.env['OAUTH2_BASE_URL'];
  static get oauth2ClientId => dotenv.env['OAUTH2_CLIENT_ID'];
  static get oauthRedirectScheme => 'lemonadesocial';
  static get webUrl => dotenv.env['WEB_URL'];

  static get backedUrl => dotenv.env['BACKEND_URL'];
  static get wssBackedUrl => dotenv.env['WSS_BACKEND_URL'];

  static get metaverseUrl => dotenv.env['METAVERSE_URL'];
  static get wssMetaverseUrl => dotenv.env['WSS_METAVERSE_URL'];
  
  // Social
  static get twitterUrl => 'https://twitter.com';
  static get instagramUrl => 'https://www.instagram.com';
  static get facebookUrl => 'https://www.facebook.com';
  static get linkedinUrl => 'https://www.linkedin.com/in';

  // Wallet connect
  static get walletConnectProjectId => dotenv.env["WALLET_CONNECT_PROJECT_ID"];

  // Matrix 
  static get matrixHomeserver => dotenv.env["MATRIX_HOMESERVER"];

  static get isProduction => dotenv.env['ENV'] == 'PROD';
  
  static const String pushNotificationsAppId = 'social.lemonade.app.staging';
  static const String pushNotificationsGatewayUrl =
      'https://d65f-115-76-94-123.ngrok.io/_matrix/push/v1/notify';
  static const String pushNotificationsPusherFormat = 'event_id_only';

}