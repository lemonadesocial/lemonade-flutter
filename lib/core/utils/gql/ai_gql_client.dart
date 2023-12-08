import 'dart:async';

import 'package:app/core/config.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/injection/register_module.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart' as ferry_hive_store;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AIClient {
  late Client _client;
  late WebSocketLink _webSocketLink;
  late AuthLink _authLink;
  late final HttpLink _httpLink = HttpLink(AppConfig.aiUrl);
  late final StreamSubscription<OAuthTokenState> tokenStateSubscription;

  Client get client => _client;

  final appOauth = getIt<AppOauth>();

  Future _initializeHive() async {
    await Hive.initFlutter();
    final box = await Hive.openBox<Map<String, dynamic>>("graphql");
    await box.clear();
    return box;
  }

  void _disposeClient() {
    _client.cache.clear();
    _client.cache.clearOptimisticPatches();
    _authLink.dispose();
    _webSocketLink.dispose();
    _client.link.dispose();
    _client.cache.dispose();
  }

  void _initializeWebSocketLink() {
    _webSocketLink = WebSocketLink(
      AppConfig.wssAIUrl,
      config: SocketClientConfig(
        initialPayload: () async {
          var token = await appOauth.getTokenForGql();
          return {
            'token': token,
          };
        },
      ),
      subProtocol: GraphQLProtocol.graphqlTransportWs,
    );
  }

  void _initializeAuthLink() {
    _authLink = AuthLink(
      getToken: () async {
        var token = await appOauth.getTokenForGql();
        return 'Bearer $token';
      },
    );
  }

  void _initializeClient() async {
    final store = ferry_hive_store.HiveStore(await _initializeHive());
    final cache = Cache(store: store);

    _client = Client(
      link: Link.from(
        [
          _authLink.split(
            (request) => request.isSubscription,
            _webSocketLink,
            _httpLink,
          ),
        ],
      ),
      cache: cache,
      updateCacheHandlers: {},
    );
  }

  void _initializeTokenStateSubscription() {
    tokenStateSubscription =
        appOauth.tokenStateStream.listen((tokenState) async {
      if (tokenState == OAuthTokenState.valid) {
        _reinitializeClient();
      } else if (tokenState == OAuthTokenState.invalid) {
        _disposeClient();
      }
    });
  }

  void _reinitializeClient() async {
    await _initializeHive();
    _initializeWebSocketLink();
    _initializeAuthLink();
    _initializeClient();
  }

  Future<void> init() async {
    await _initializeHive();
    _initializeWebSocketLink();
    _initializeAuthLink();
    _initializeClient();
    _initializeTokenStateSubscription();
  }
}
