import 'dart:io';

import 'package:app/core/config.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:app/core/service/auth_method_tracker/auth_method_tracker.dart';
import 'package:app/core/service/ory_auth/ory_auth.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_wallet_card/core/passkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_wallet_card/flutter_wallet_card.dart';
import 'package:path_provider/path_provider.dart';

class EventPassService {
  final _appOauth = getIt<AppOauth>();
  final _oryAuth = getIt<OryAuth>();
  final _browser = InAppBrowser();
  final http.Client _client = http.Client();
  EventPassService();

  Future<void> generateApplePassKit({required String ticketId}) async {
    final token = await _appOauth.getTokenForGql();
    try {
      final response = await _client.get(
        Uri.parse("${AppConfig.rootBackendUrl}/event/pass/apple/$ticketId"),
        headers: {"Authorization": 'Bearer $token'},
      );
      // Collect bytes data & write data to 1 single apple pass
      final bytes = response.bodyBytes;
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/apple_pass.pass';
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      final passkit = await Passkit().saveFromPath(id: 'apple', file: file);
      await FlutterWalletCard.addPasskit(passkit);
      await file.delete();
    } catch (e) {
      debugPrint('Error generating Apple PassKit: $e');
    }
  }

  Future<void> generateGooglePassKit({required String ticketId}) async {
    final authMethod = await getIt<AuthMethodTracker>().getAuthMethod();
    final token = authMethod == AuthMethod.oauth
        ? await _appOauth.getTokenForGql()
        : await _oryAuth.getTokenForGql();
    try {
      await _browser.openUrlRequest(
        urlRequest: URLRequest(
          url: WebUri(
            "${AppConfig.rootBackendUrl}/event/pass/google/$ticketId",
          ),
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      debugPrint('Error generating Google PassKit: $e');
    }
  }
}
