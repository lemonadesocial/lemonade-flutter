import 'package:app/app.dart';
import 'package:app/core/service/firebase/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql_flutter;
import 'package:app/injection/register_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await gql_flutter.initHiveForFlutter();
  
  final messagingService = FirebaseService();
  await messagingService.initialize();
  final token = await messagingService.registerToken();
  
  print('FCM Token: $token');
  
  registerModule();

  runApp(LemonadeApp());

  debugPrint('App is ready!!! ✅');
}
