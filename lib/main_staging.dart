import 'package:app/app.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql_flutter;
import 'package:app/injection/register_module.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Create an instance of the ShorebirdCodePush class
  final shorebirdCodePush = ShorebirdCodePush();

  // Get the current patch version, or null if no patch is installed.
  final currentPatchversion = await shorebirdCodePush.currentPatchNumber();
  // ignore: avoid_print
  print("currentPatchversion : $currentPatchversion");

  // Check whether a patch is available to install.
  final isUpdateAvailable =
      await shorebirdCodePush.isNewPatchAvailableForDownload();
  // ignore: avoid_print
  print("isUpdateAvailable : $isUpdateAvailable");

  // Download a new patch.
  await shorebirdCodePush.downloadUpdateIfAvailable();

  await dotenv.load(fileName: '.env.staging');
  await gql_flutter.initHiveForFlutter();

  registerModule();

  await getIt<AppOauth>().init();
  if (!kDebugMode) {
    await getIt<FirebaseService>().initialize();
  }
  await getIt<MatrixService>().init();

  runApp(const LemonadeApp());

  debugPrint('App is ready!!! ✅');
}
