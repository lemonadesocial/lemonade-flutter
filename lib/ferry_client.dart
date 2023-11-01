import 'package:app/core/config.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/injection/register_module.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FerryClient {
  late Client _client;
  Client get client => _client;

  init() async {
    await Hive.initFlutter();

    final box = await Hive.openBox<Map<String, dynamic>>("graphql");
    await box.clear();
    final store = HiveStore(box);
    final cache = Cache(store: store);

    final token = await getIt<AppOauth>().getTokenForGql();
    final defaultHeaders = {"Authorization": "Bearer $token"};
    final link = HttpLink(AppConfig.backedUrl, defaultHeaders: defaultHeaders);

    _client = Client(
      link: link,
      cache: cache,
    );
  }
}
