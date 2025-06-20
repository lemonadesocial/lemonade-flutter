import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class ZKSyncEip712Transaction {
  String to;
  String from;
  BigInt nonce;
  BigInt gas;
  BigInt maxPriorityFeePerGas;
  BigInt maxFeePerGas;
  String data;
  BigInt value;
  BigInt chainId;
  BigInt? gasPerPubdata;
  String? customSignature;
  String? paymaster;
  String? paymasterInput;
  List<String>? factoryDeps;

  ZKSyncEip712Transaction({
    required this.from,
    required this.to,
    required this.gas,
    this.gasPerPubdata,
    required this.maxFeePerGas,
    required this.maxPriorityFeePerGas,
    required this.nonce,
    required this.data,
    required this.value,
    required this.chainId,
    this.customSignature,
    this.paymaster,
    this.paymasterInput,
    this.factoryDeps,
  });

  List<dynamic> toJson() {
    return [
      EthereumAddress.fromHex(from),
      EthereumAddress.fromHex(to),
      gas,
      gasPerPubdata,
      maxFeePerGas,
      maxPriorityFeePerGas,
      (paymaster != null) ? paymaster : null,
      nonce,
      value,
      hexToBytes(data),
      factoryDeps,
      paymasterInput,
    ];
  }

  Map<String, dynamic> toTypedData() {
    return {
      'txType': '113',
      'from': BigInt.parse(from).toString(),
      'to': BigInt.parse(to).toString(),
      'gasLimit': gas.toString(),
      'gasPerPubdataByteLimit': gasPerPubdata.toString(),
      'maxFeePerGas': maxFeePerGas.toString(),
      'maxPriorityFeePerGas': maxPriorityFeePerGas.toString(),
      'paymaster': paymaster != null ? BigInt.parse(paymaster!).toString() : 0,
      'nonce': nonce.toString(),
      'value': value.toString(),
      'data': data,
      'factoryDeps': factoryDeps ?? [],
      'paymasterInput': paymasterInput ?? '0x',
    };
  }

  List<dynamic> toList(customSignature) {
    final list = [
      nonce,
      maxPriorityFeePerGas,
      maxFeePerGas,
      gas,
      EthereumAddress.fromHex(to).addressBytes,
      value,
      hexToBytes(data),
      chainId,
      hexToBytes("0x"),
      hexToBytes("0x"),
      chainId,
      EthereumAddress.fromHex(from).addressBytes,
      gasPerPubdata ?? 0,
      factoryDeps ?? [],
      hexToBytes(customSignature),
    ];
    if (paymaster != null && paymasterInput != null) {
      list.add([
        EthereumAddress.fromHex(paymaster!).addressBytes,
        hexToBytes(paymasterInput!),
      ]);
    } else {
      list.add([]);
    }
    return list;
  }

  static const types = {
    'EIP712Domain': [
      {'name': 'name', 'type': 'string'},
      {'name': 'version', 'type': 'string'},
      {'name': 'chainId', 'type': 'uint256'},
    ],
    'Transaction': [
      {'name': 'txType', 'type': 'uint256'},
      {'name': 'from', 'type': 'uint256'},
      {'name': 'to', 'type': 'uint256'},
      {'name': 'gasLimit', 'type': 'uint256'},
      {'name': 'gasPerPubdataByteLimit', 'type': 'uint256'},
      {'name': 'maxFeePerGas', 'type': 'uint256'},
      {'name': 'maxPriorityFeePerGas', 'type': 'uint256'},
      {'name': 'paymaster', 'type': 'uint256'},
      {'name': 'nonce', 'type': 'uint256'},
      {'name': 'value', 'type': 'uint256'},
      {'name': 'data', 'type': 'bytes'},
      {'name': 'factoryDeps', 'type': 'bytes32[]'},
      {'name': 'paymasterInput', 'type': 'bytes'},
    ],
  };

  static const primaryType = 'Transaction';
}
