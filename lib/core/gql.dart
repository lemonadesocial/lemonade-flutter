import 'package:app/core/config.dart';
import 'package:app/core/oauth.dart';
import 'package:app/injection/register_module.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

class BaseGQL {
  final String httpUrl;
  final String wssUrl;

  final appOauth = getIt<AppOauth>();

  late final GraphQLClient _client;
  late final AuthLink _authLink;

  late final HttpLink _httpLink = HttpLink(httpUrl);

  late final WebSocketLink _webSocketLink = WebSocketLink(
    wssUrl,
    config: SocketClientConfig(
      autoReconnect: true,
    ),
    subProtocol: GraphQLProtocol.graphqlTransportWs
  );

  GraphQLClient get client => _client;

  BaseGQL({
    required this.httpUrl,
    required this.wssUrl,
  }) {
    _authLink = AuthLink(getToken: () async {
      return await appOauth.getTokenForGql();
    });

    _client = GraphQLClient(
      defaultPolicies: DefaultPolicies(
          query: Policies(
        fetch: FetchPolicy.cacheAndNetwork,
      )),
      link: _authLink.split(
        (request) {
          return request.isSubscription;
        },
        _webSocketLink,
        _httpLink,
      ),
      cache: GraphQLCache(store: HiveStore()),
    );
  }
}

@lazySingleton
class MetaverseGQL extends BaseGQL {
  MetaverseGQL()
      : super(
          httpUrl: AppConfig.metaverseUrl,
          wssUrl: AppConfig.wssMetaverseUrl,
        );
}

@lazySingleton
class AppGQL extends BaseGQL {
  AppGQL()
      : super(
          httpUrl: AppConfig.backedUrl,
          wssUrl: AppConfig.wssBackedUrl,
        );
}
