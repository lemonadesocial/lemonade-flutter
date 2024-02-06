import 'package:freezed_annotation/freezed_annotation.dart';

part 'ethereum_transaction.freezed.dart';
part 'ethereum_transaction.g.dart';

@freezed
class EthereumTransaction with _$EthereumTransaction {
  EthereumTransaction._();

  @JsonSerializable(includeIfNull: false)
  factory EthereumTransaction({
    required String from,
    required String to,
    required String value,
    String? nonce,
    String? gasPrice,
    String? maxFeePerGas,
    String? maxPriorityFeePerGas,
    String? gas,
    String? gasLimit,
    String? data,
  }) = _EthereumTransaction;

  factory EthereumTransaction.fromJson(Map<String, dynamic> json) =>
      _$EthereumTransactionFromJson(json);

  @override
  String toString() {
    return 'WCEthereumTransaction(from: $from, to: $to, nonce: $nonce, gasPrice: $gasPrice, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas, gas: $gas, gasLimit: $gasLimit, value: $value, data: $data)';
  }
}
