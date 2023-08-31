import 'package:app/app.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql_flutter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await gql_flutter.initHiveForFlutter();
  
  registerModule();

  await getIt<AppOauth>().init();

  runApp(const LemonadeApp());

  debugPrint('App is ready!!! ✅');
}
