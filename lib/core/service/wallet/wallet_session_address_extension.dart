import 'package:reown_appkit/reown_appkit.dart';

extension WalletSessionAddressExtension on ReownAppKitModalSession {
  String? get address {
    // TODO: Solana address is not supported yet
    return getAddress("eip155");
  }
}
