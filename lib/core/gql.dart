import 'package:app/core/oauth.dart';
import 'package:app/injection/register_module.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppGQL {
  final appOauth = getIt<AppOauth>();

  late final GraphQLClient _client;
  late final AuthLink _authLink;

  final HttpLink _httpLink = HttpLink(
    'https://backend.staging.lemonade.social/graphql',
  );

  GraphQLClient get client => _client;

  AppGQL() {
    _authLink = AuthLink(
      getToken: () async {
        return await appOauth.getTokenForGql();
      },
    );
    _client = GraphQLClient(
      defaultPolicies: DefaultPolicies(
          query: Policies(
        fetch: FetchPolicy.cacheAndNetwork,
      )),
      link: _authLink.concat(_httpLink),
      cache: GraphQLCache(store: HiveStore()),
    );
  }
}
