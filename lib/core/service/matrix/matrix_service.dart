import 'package:app/core/config.dart';
import 'package:app/core/data/matrix/matrix_mutation.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/matrix/matrix_chat_space_extension.dart';
import 'package:app/core/utils/chat_notification/background_push.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:matrix/encryption/utils/key_verification.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';

@LazySingleton()
class MatrixService {
  static String clientName = 'LemonadeChat';
  static String dbName = 'matrix_lemonade_chat';

  late Client _client;
  late BackgroundPush backgroundPush;

  Client get client => _client;

  init() async {
    _client = _createClient();
    await _client.init(
      waitForFirstSync: false,
      waitUntilLoadCompletedLoaded: false,
    );
    backgroundPush = BackgroundPush(client);
    getIt<AppOauth>().tokenStateStream.listen((tokenState) async {
      if (tokenState == OAuthTokenState.valid) {
        if (!_client.isLogged()) {
          await login();
        }
        await _client.roomsLoading;
        await _client.accountDataLoading;
        await backgroundPush.setupPush();
        await _disableGroupChatNotifications();
        return;
      }

      if (tokenState == OAuthTokenState.invalid) {
        if (client.isLogged()) {
          await clearChatSpaceBox();
          await _client.logout();
        }
      }
    });
  }

  Future<void> login() async {
    try {
      var jwtToken = await _generateJWTMatrixToken();
      await _client.checkHomeserver(
        Uri.parse(AppConfig.matrixHomeserver),
      );
      _client
          .login(
            LoginType.mLoginJwt,
            token: jwtToken,
          )
          .then((value) async => {await backgroundPush.setupPush()});
    } catch (e) {
      debugPrint("error : $e");
    }
  }

  Future<void> logout() async {
    if (!_client.isLogged()) return;
    _client.logout();
  }

  Future<String> _generateJWTMatrixToken() async {
    var result = await getIt<AppGQL>().client.mutate<String>(
          MutationOptions(
            document: generateMatrixTokenMutation,
            fetchPolicy: FetchPolicy.networkOnly,
            parserFn: (data) => data['generateMatrixToken'] ?? '',
          ),
        );
    if (result.hasException) throw Exception(result.exception.toString());
    return result.parsedData ?? '';
  }

  Client _createClient() {
    return Client(
      clientName,
      verificationMethods: {
        KeyVerificationMethod.numbers,
        KeyVerificationMethod.emoji,
      },
      // TODO: will figure out later the need of important state events
      // importantStateEvents: <String>{
      //   // To make room emotes work
      //   'im.ponies.room_emotes',
      //   // To check which story room we can post in
      //   EventTypes.RoomPowerLevels,
      // },
      logLevel: kReleaseMode ? Level.warning : Level.verbose,
      databaseBuilder: (_) async {
        final dir = await getApplicationSupportDirectory();
        final db = HiveCollectionsDatabase(dbName, dir.path);
        await db.open();
        return db;
      },
      supportedLoginTypes: {
        AuthenticationTypes.password,
        AuthenticationTypes.sso,
      },
      nativeImplementations: NativeImplementationsIsolate(compute),
    );
  }

  Future<void> _disableGroupChatNotifications() async {
    try {
      final rooms = _client.rooms;
      for (final room in rooms) {
        // Set don't notify for group chats
        if (!room.isDirectChat &&
            room.pushRuleState != PushRuleState.dontNotify) {
          await room.setPushRuleState(PushRuleState.dontNotify);
        }
      }
    } catch (e) {
      // Setting push rules for certain rooms may throw errors but the setPushRuleState still works correctly,
      // so we ignore them to keep logs clean
    }
  }
}
