import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class WCUtils {
  static List<String> getSessionsAccounts(Map<String, Namespace> namespaces) {
    return namespaces[WalletConnectService.defaultNamespace]?.accounts ?? [];
  }

  static List<String> getSessionsChains(Map<String, Namespace>? namespaces) {
    if (namespaces == null) return [];
    return NamespaceUtils.getChainsFromAccounts(
      getSessionsAccounts(namespaces),
    );
  }
}
