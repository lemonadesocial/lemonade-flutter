import 'dart:convert';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

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
