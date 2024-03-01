import 'package:app/app.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql_flutter;
import 'package:app/injection/register_module.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await gql_flutter.initHiveForFlutter();

  registerModule();

  await getIt<AppOauth>().init();
  await getIt<FirebaseService>().initialize();
  await getIt<MatrixService>().init();
  await getIt<WalletConnectService>().init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const LemonadeApp());
  });
  debugPrint('App is ready!!! ✅');
}
