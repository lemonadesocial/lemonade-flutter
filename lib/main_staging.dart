import 'package:app/app.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql_flutter;
import 'package:app/injection/register_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.staging');
  await gql_flutter.initHiveForFlutter();

  registerModule();

  await getIt<AppOauth>().init();
  await getIt<FirebaseService>().initialize();
  await getIt<MatrixService>().init();

  runApp(LemonadeApp());

  debugPrint('App is ready!!! ✅');
}
