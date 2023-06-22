// Flutter web plugin registrant file.
//
// Generated file. Do not edit.
//

// @dart = 2.13
// ignore_for_file: type=lint

import 'package:connectivity_plus/src/connectivity_plus_web.dart';
import 'package:flutter_secure_storage_web/flutter_secure_storage_web.dart';
import 'package:flutter_web_auth_2/src/flutter_web_auth_2_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins([final Registrar? pluginRegistrar]) {
  final Registrar registrar = pluginRegistrar ?? webPluginRegistrar;
  ConnectivityPlusWebPlugin.registerWith(registrar);
  FlutterSecureStorageWeb.registerWith(registrar);
  FlutterWebAuth2WebPlugin.registerWith(registrar);
  UrlLauncherPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
