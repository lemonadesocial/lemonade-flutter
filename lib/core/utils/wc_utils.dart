import 'package:app/core/service/wallet_connect/wallet_connect_service.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class WCUtils {
  static List<String> getSessionsAccounts(Map<String, Namespace> namespaces) {
    return namespaces[WalletConnectService.defaultNamespace]?.accounts ?? [];
  }

  static List<String> getSessionsChains(Map<String, Namespace>? namespaces) {
    if (namespaces == null) return [];
    return NamespaceUtils.getChainsFromAccounts(
        getSessionsAccounts(namespaces));
  }
}
