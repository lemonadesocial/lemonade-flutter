import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql_flutter;
import 'package:app/injection/register_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await gql_flutter.initHiveForFlutter();

  registerModule();

  runApp(LemonadeApp());

  debugPrint('App is ready!!! ✅');
}
