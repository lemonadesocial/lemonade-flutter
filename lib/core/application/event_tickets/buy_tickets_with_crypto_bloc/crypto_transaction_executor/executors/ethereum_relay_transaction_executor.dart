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
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:convert/convert.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class EthereumRelayTransactionExecutor implements CryptoTransactionExecutor {
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
    final relayContract = Web3ContractService.getRelayPaymentContract(
      chain.relayPaymentContract ?? '',
    );
    // token address (can be native token or ERC20 token)
    final erc20currencyAddress = paymentAccount
            .accountInfo?.currencyMap?[currency]?.contracts?[network] ??
        '';
    try {
      if (erc20currencyAddress != zeroAddress) {
        erc20ApproveTxHash = await Web3Utils.approveSpender(
          erc20Address: erc20currencyAddress,
          from: from,
          spender: chain.relayPaymentContract ?? '',
          amount: amount,
          chain: chain,
        );
      }
    } catch (e) {
      throw CryptoTransactionException(e.toString());
    }
    final contractCallTxn = Transaction.callContract(
      contract: relayContract,
      function: relayContract.function('pay'),
      parameters: [
        EthereumAddress.fromHex(
          paymentAccount.accountInfo?.paymentSplitterContract ?? '',
        ),
        eventId,
        payment.id,
        EthereumAddress.fromHex(erc20currencyAddress),
        amount,
      ],
    );
    final ethereumTransaction = EthereumTransaction(
      from: from,
      to: chain.relayPaymentContract ?? '',
      value: (erc20currencyAddress == zeroAddress ? amount : BigInt.zero)
          .toRadixString(16),
      data: hex.encode(List<int>.from(contractCallTxn.data!)),
    );
    String txHash = '';
    try {
      txHash = await getIt<WalletConnectService>()
          .requestTransaction(
            chainId: chain.fullChainId ?? '',
            transaction: ethereumTransaction,
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
