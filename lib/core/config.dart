// ignore_for_file: always_declare_return_types
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static get env => dotenv.env['ENV'];
  static get oauth2BaseUrl => dotenv.env['OAUTH2_BASE_URL'];
  static get oauth2ClientId => dotenv.env['OAUTH2_CLIENT_ID'];
  static get oauthRedirectScheme => dotenv.env['OAUTH2_REDIRECT_SCHEME'];
  static get webUrl => dotenv.env['WEB_URL'];

  static get backedUrl => dotenv.env['BACKEND_URL'];
  static get wssBackedUrl => dotenv.env['WSS_BACKEND_URL'];
  static get assetPrefix => dotenv.env['ASSET_PREFIX'];

  static get metaverseUrl => dotenv.env['METAVERSE_URL'];
  static get wssMetaverseUrl => dotenv.env['WSS_METAVERSE_URL'];

  static get walletUrl => dotenv.env['WALLET_URL'];
  static get wssWalletUrl => dotenv.env['WSS_WALLET_URL'];

  static get aiUrl => dotenv.env['AI_URL'];
  static get wssAIUrl => dotenv.env['WSS_AI_URL'];

  static get isProduction => dotenv.env['ENV'] == 'production';

  // Social
  static get twitterUrl => 'https://twitter.com';
  static get instagramUrl => 'https://www.instagram.com';
  static get facebookUrl => 'https://www.facebook.com';
  static get linkedinUrl => 'https://www.linkedin.com/in';
  static get githubUrl => 'https://github.com';
  static get mirrorUrl => 'https://mirror.xyz';
  static get farcasterUrl => 'https://www.farcaster.xyz';
  static get lensUrl => 'https://www.lens.xyz';
  static get calendlyUrl => 'https://calendly.com';

  // Wallet connect
  static get walletConnectProjectId => dotenv.env['WALLET_CONNECT_PROJECT_ID'];

  // Matrix
  static get matrixHomeserver => dotenv.env['MATRIX_HOMESERVER'];

  /// Matrix chat
  static get pushNotificationsAppId => dotenv.env['PUSH_NOTIFICATION_APP_ID'];

  static get pushNotificationsGatewayUrl =>
      dotenv.env['PUSH_NOTIFICATION_GATEWAY_URL'];

  static get hideTypingUsernames => false;

  // Google map
  static get googleMapKey => dotenv.env['GOOGLE_MAP_KEY'];

  // Appcast
  static get appCastUrl => dotenv.env['APPCAST_URL'];

  static get appScheme => dotenv.env['APP_SCHEME'];

  // Chat AI
  static get aiConfig => dotenv.env['AI_CONFIG'];

  // Chat LemonAI config
  static get chatLemonAIConfig => dotenv.env['CHAT_LEMON_AI_CONFIG'];

  // Crypto cramp
  static get stripeOnrampHost => dotenv.env['STRIPE_ONRAMP_HOST'];

  // Sentry DSN
  static get sentryDsn => dotenv.env['SENTRY_DSN'];
}
