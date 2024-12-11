import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/web3/entities/chain.dart';

class CryptoTransactionExecutionResult {
  final String txHash;
  final String? erc20ApproveTxHash;

  CryptoTransactionExecutionResult({
    required this.txHash,
    this.erc20ApproveTxHash,
  });
}

class CryptoTransactionException implements Exception {
  final String? message;

  CryptoTransactionException(this.message);
}

abstract class CryptoTransactionExecutor {
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
  });
}
