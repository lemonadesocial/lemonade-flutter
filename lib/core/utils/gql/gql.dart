import 'dart:async';
import 'dart:io';

import 'package:app/core/config.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/cubejs/cubejs_repository.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/lens/lens_storage_service/lens_storage_service.dart';
import 'package:app/core/utils/gql/custom_error_handler.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

class GeoLocationLink extends Link {
  GeoLocationLink({
    required this.geoPoint,
  });
  final GeoPoint geoPoint;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final req = request.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: {
          // put oldest headers
          ...headers?.headers ?? <String, String>{},
          'x-geolocation-latitude': '${geoPoint.lat}',
          'x-geolocation-longitude': '${geoPoint.lng}',
        },
      ),
    );
    yield* forward!(req);
  }
}

class CustomUserAgentLink extends Link {
  CustomUserAgentLink();

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final packageInfo = await PackageInfo.fromPlatform();
    final userAgent =
        '${packageInfo.appName}/${packageInfo.version} (${Platform.operatingSystem})';
    final req = request.updateContextEntry<HttpLinkHeaders>(
      (headers) => HttpLinkHeaders(
        headers: {
          // put oldest headers
          ...headers?.headers ?? <String, String>{},
          'User-Agent': userAgent,
        },
      ),
    );
    yield* forward!(req);
  }
}

class BaseGQL {
  BaseGQL({
    required this.httpUrl,
    required this.wssUrl,
    this.customLinks = const [],
  }) {
    _authLink = AuthLink(
      getToken: () async {
        var token = await appOauth.getTokenForGql();
        return 'Bearer $token';
      },
    );
    _errorLink = ErrorLink(
      onException: (request, forward, exception) =>
          CustomErrorHandler.handleExceptionError(request, forward, exception),
      onGraphQLError: (request, forward, response) =>
          CustomErrorHandler.handleGraphQLError(request, forward, response),
    );

    _client = GraphQLClient(
      queryRequestTimeout: const Duration(seconds: 30),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.cacheAndNetwork,
        ),
      ),
      link: Link.from([
        _errorLink,
        ...customLinks,
        _authLink.split(
          (request) {
            return request.isSubscription;
          },
          _webSocketLink,
          _httpLink,
        ),
      ]),
      cache: GraphQLCache(
        partialDataPolicy: PartialDataCachePolicy.accept,
        store: HiveStore(),
      ),
    );

    tokenStateSubscription = appOauth.tokenStateStream.listen((tokenState) {
      if (tokenState == OAuthTokenState.invalid) {
        _webSocketLink.dispose();
        _client.resetStore();
      }
    });
  }
  final appOauth = getIt<AppOauth>();
  final String httpUrl;
  final String wssUrl;
  late final StreamSubscription<OAuthTokenState> tokenStateSubscription;
  late final GraphQLClient _client;
  late final AuthLink _authLink;
  late final ErrorLink _errorLink;
  late final HttpLink _httpLink = HttpLink(httpUrl);
  late final WebSocketLink _webSocketLink = WebSocketLink(
    wssUrl,
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
  final List<Link> customLinks;
  GraphQLClient get client => _client;

  Future<void> dispose() async {
    await tokenStateSubscription.cancel();
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
          customLinks: [CustomUserAgentLink()],
        );
}

@lazySingleton
class WalletGQL extends BaseGQL {
  WalletGQL()
      : super(
          httpUrl: AppConfig.walletUrl,
          wssUrl: AppConfig.wssWalletUrl,
        );
}

class GeoLocationBasedGQL extends BaseGQL {
  GeoLocationBasedGQL(
    GeoLocationLink link,
  ) : super(
          httpUrl: AppConfig.backedUrl,
          wssUrl: AppConfig.wssBackedUrl,
          customLinks: [link],
        );
}

@lazySingleton
class AIGQL extends BaseGQL {
  AIGQL()
      : super(
          httpUrl: AppConfig.aiUrl,
          wssUrl: AppConfig.wssAIUrl,
        );
}

class CubeGQL {
  final String eventId;
  CubeGQL({
    required this.eventId,
  }) {
    _errorLink = ErrorLink(
      onException: (request, forward, exception) {
        if (kDebugMode) {
          CustomErrorHandler.handleExceptionError(request, forward, exception);
        }
        return null;
      },
      onGraphQLError: (request, forward, response) {
        if (kDebugMode) {
          CustomErrorHandler.handleGraphQLError(request, forward, response);
        }
        return null;
      },
    );

    _client = GraphQLClient(
      queryRequestTimeout: const Duration(seconds: 30),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.cacheAndNetwork,
        ),
      ),
      link: Link.from([
        _errorLink,
        AuthLink(
          getToken: () async {
            final result = await getIt<CubeJsRepository>()
                .generateCubejsToken(eventId: eventId);
            final cubeToken = result.getOrElse(() => '');
            return cubeToken;
          },
        ),
        HttpLink(
          AppConfig.cubeJsUrl,
          defaultHeaders: {
            'Content-Type': 'application/json',
          },
        ),
      ]),
      cache: GraphQLCache(
        partialDataPolicy: PartialDataCachePolicy.accept,
        store: HiveStore(),
      ),
    );
  }

  final appOauth = getIt<AppOauth>();
  late final GraphQLClient _client;
  late final ErrorLink _errorLink;
  GraphQLClient get client => _client;
}

@LazySingleton()
class AirstackGQL {
  AirstackGQL() {
    _errorLink = ErrorLink(
      onException: (request, forward, exception) {
        if (kDebugMode) {
          CustomErrorHandler.handleExceptionError(request, forward, exception);
        }
        return null;
      },
      onGraphQLError: (request, forward, response) {
        if (kDebugMode) {
          CustomErrorHandler.handleGraphQLError(request, forward, response);
        }
        return null;
      },
    );

    _client = GraphQLClient(
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.cacheAndNetwork,
        ),
      ),
      link: Link.from([
        _errorLink,
        HttpLink(
          AppConfig.airstackUrl,
          defaultHeaders: {
            'Content-Type': 'application/json',
          },
        ),
      ]),
      cache: GraphQLCache(
        partialDataPolicy: PartialDataCachePolicy.accept,
        store: HiveStore(),
      ),
    );
  }

  late final GraphQLClient _client;
  late final ErrorLink _errorLink;
  GraphQLClient get client => _client;
}

@LazySingleton()
class LensGQL {
  LensGQL() {
    _errorLink = ErrorLink(
      onException: (request, forward, exception) {
        if (kDebugMode) {
          CustomErrorHandler.handleExceptionError(request, forward, exception);
        }
        return null;
      },
      onGraphQLError: (request, forward, response) {
        if (kDebugMode) {
          CustomErrorHandler.handleGraphQLError(request, forward, response);
        }
        return null;
      },
    );
    _authLink = AuthLink(
      getToken: () async {
        var token = await getIt<LensStorageService>().getAccessTokenForQql();
        if (token == null) {
          return null;
        }
        return 'Bearer $token';
      },
    );
    _client = GraphQLClient(
      queryRequestTimeout: const Duration(seconds: 30),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.cacheAndNetwork,
        ),
      ),
      link: Link.from([
        _errorLink,
        _authLink,
        HttpLink(
          AppConfig.lensApiUrl,
          defaultHeaders: {
            'Content-Type': 'application/json',
            'Origin': AppConfig.webUrl,
          },
        ),
      ]),
      cache: GraphQLCache(
        partialDataPolicy: PartialDataCachePolicy.accept,
        store: HiveStore(),
      ),
    );
  }

  late final AuthLink _authLink;
  late final GraphQLClient _client;
  late final ErrorLink _errorLink;
  GraphQLClient get client => _client;
}
