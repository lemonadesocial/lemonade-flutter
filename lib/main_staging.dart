import 'package:app/app.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql_flutter;
import 'package:app/injection/register_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env.staging');
  await gql_flutter.initHiveForFlutter();

  final firebaseService = FirebaseService();
  await firebaseService.initialize();
  final token = await firebaseService.getToken();
  
  debugPrint('FCM Token: $token');
  
  registerModule();

  await getIt<AppOauth>().init();

  runApp(LemonadeApp());

  debugPrint('App is ready!!! ✅');
}
