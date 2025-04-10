import 'dart:async';
import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/crypto_transaction_executor/crypto_transaction_executor.dart';
import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/entities/ethereum_transaction.dart';
import 'package:app/core/service/wallet/rpc_error_handler_extension.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/web3_contract_service.dart';
import 'package:app/injection/register_module.dart';
import 'package:convert/convert.dart';
import 'package:reown_appkit/reown_appkit.dart';

class EthereumTransactionExecutor implements CryptoTransactionExecutor {
  @override
  Future<CryptoTransactionExecutionResult> execute({
    required String eventId,
    required String from,
    required String to,
    required BigInt amount,
    required String currency,
    required CurrencyInfo currencyInfo,
    required Chain chain,
    required PaymentAccount paymentAccount,
    required Payment payment,
  }) async {
    final network = paymentAccount.accountInfo?.network;
    String erc20ApproveTxHash = '';
    // token address (can be native token or ERC20 token)
    final erc20currencyAddress = paymentAccount
            .accountInfo?.currencyMap?[currency]?.contracts?[network] ??
        '';
    EthereumTransaction ethereumTxn;
    if (erc20currencyAddress != zeroAddress) {
      final contract =
          Web3ContractService.getERC20Contract(erc20currencyAddress);
      final contractCallTxn = Transaction.callContract(
        contract: contract,
        function: contract.function('transfer'),
        parameters: [
          EthereumAddress.fromHex(to),
          amount,
        ],
      );
      ethereumTxn = EthereumTransaction(
        from: from,
        to: erc20currencyAddress,
        value: BigInt.zero.toRadixString(16),
        data: hex.encode(List<int>.from(contractCallTxn.data!)),
      );
    } else {
      ethereumTxn = EthereumTransaction(
        from: from,
        to: to,
        value: amount.toRadixString(16),
      );
    }

    String txHash = '';
    try {
      txHash = await getIt<WalletConnectService>()
          .requestTransaction(
            chainId: chain.fullChainId ?? '',
            transaction: ethereumTxn,
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );
    } catch (e) {
      if (e is TimeoutException) {
        throw CryptoTransactionException('Timeout');
      }
      throw CryptoTransactionException(
        e is JsonRpcError
            ? getIt<WalletConnectService>().getMessageFromRpcError(e)
            : e.toString(),
      );
    }
    if (!txHash.startsWith('0x')) {
      throw CryptoTransactionException(txHash);
    }
    return CryptoTransactionExecutionResult(
      txHash: txHash,
      erc20ApproveTxHash: erc20ApproveTxHash,
    );
  }
}
