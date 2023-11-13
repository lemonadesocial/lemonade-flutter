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

  init() async {
    final appOauth = getIt<AppOauth>();

    await Hive.initFlutter();

    final box = await Hive.openBox<Map<String, dynamic>>("graphql");
    await box.clear();
    final store = ferry_hive_store.HiveStore(box);
    final cache = Cache(store: store);

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

    _authLink = AuthLink(
      getToken: () async {
        var token = await appOauth.getTokenForGql();
        return 'Bearer $token';
      },
    );

    _client = Client(
      link: Link.from(
        [
          _authLink.split(
            (request) {
              return request.isSubscription;
            },
            _webSocketLink,
            _httpLink,
          ),
        ],
      ),
      cache: cache,
      updateCacheHandlers: {
        // unrelated to the isolate: update the list of authors in the cache when a new author is created
      },
    );

    tokenStateSubscription = appOauth.tokenStateStream.listen((tokenState) {
      if (tokenState == OAuthTokenState.invalid) {
        _webSocketLink.dispose();
        _client.cache.dispose();
        _client.cache.clear();
        _client.cache.clearOptimisticPatches();
      }
    });
  }
}
