import 'dart:io';

import 'package:app/core/config.dart';
import 'package:app/core/oauth/oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallet_card/core/passkit.dart';
import 'package:http/http.dart';
import 'package:flutter_wallet_card/flutter_wallet_card.dart';
import 'package:path_provider/path_provider.dart';

class EventPassService {
  final Client _client = Client();
  EventPassService();

  Future<void> generateApplePassKit({required String ticketId}) async {
    final appOauth = AppOauth();
    final token = await appOauth.getTokenForGql();

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
}
