import 'dart:convert';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

extension RpcErrorHandler on WalletConnectService {
  String? getMessageFromRpcError(JsonRpcError e) {
    try {
      if (e.message == null) return null;
      final message = jsonDecode(e.message!)['message'];
      return message;
    } catch (error) {
      return e.message;
    }
  }
}
