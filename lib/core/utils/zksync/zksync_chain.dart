import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/core/utils/zksync/eip_712_transaction.dart';
import 'package:eth_sig_util/model/typed_data.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart';
// ignore: implementation_imports
import 'package:web3dart/src/utils/rlp.dart' as rlp;

/// A class representing all ZKSync based chains. This class allows
/// configuration of necessary EIP712 fields required to build transactions
/// on zksync chains

/// Example usage:
/// ```dart
/// final zkSyncChain = ZKSyncChain({
///  rpcUrl: 'https://rinkeby.infura.io/v3/your_project_id',
///  eip712domain: EIP712Domain(
///    name: 'ZKSync',
///    version: '1',
///    chainId: 4,
///    verifyingContract: '0x',
///    salt: ''
/// });
/// ```
///
class ZKSyncChain {
  // The RPC URL of the node you are accessing for the given ZKSync chain.
  final String rpcUrl;

  /// ZKSync bakes 712 support in at the protocol level.
  /// Therefore, these values should be defined at the chain level.
  /// This ensures that the necessary parameters are correctly set
  /// and managed within the blockchain network, providing a seamless
  /// and efficient integration of the 712 standard.
  final EIP712Domain eip712domain;

  ZKSyncChain({required this.rpcUrl, required this.eip712domain});

  Future<String> sendTransaction(
    ZKSyncEip712Transaction transaction,
    WalletConnectService walletConnectService,
  ) async {
    final eip712Data = {
      'domain': eip712domain.toJson(),
      'message': transaction.toTypedData(),
      'primaryType': ZKSyncEip712Transaction.primaryType,
      'types': ZKSyncEip712Transaction.types,
    };
    final signature = await walletConnectService.signTypedDataV4(
      chainId: 'eip155:${eip712domain.chainId}',
      data: eip712Data,
      wallet: walletConnectService.w3mService?.session?.address ?? '',
    );

    final client = Web3Client(rpcUrl, http.Client());
    final serializedTx = transaction.toList(signature);
    final rawTx = hexToBytes(
      Web3Utils.concatHex(["0x71", bytesToHex(rlp.encode(serializedTx))]),
    );
    final txHash = await client.sendRawTransaction(rawTx);
    return txHash;
  }
}
