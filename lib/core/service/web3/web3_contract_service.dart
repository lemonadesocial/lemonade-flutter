import 'package:app/core/service/web3/erc20.dart';
import 'package:app/core/service/web3/escrow/contracts/lemonade_escrow_factory_v1_contract_abi.dart';
import 'package:app/core/service/web3/escrow/contracts/lemonade_escrow_v1_contract_abi.dart';
import 'package:app/core/service/web3/lemonade_relay/contracts/lemonade_payment_splitter_contract_abi.dart';
import 'package:app/core/service/web3/lemonade_relay/contracts/lemonade_relay_payment_contract_abi.dart';
import 'package:app/core/service/web3/stake/contracts/lemonade_stake_payment_contract_abi.dart';
import 'package:web3dart/web3dart.dart';

class Web3ContractService {
  static DeployedContract getERC20Contract(String contractAddress) {
    return DeployedContract(
      ContractAbi.fromJson(erc20Abi, ''),
      EthereumAddress.fromHex(contractAddress),
    );
  }

  static DeployedContract getEscrowFactoryContract(String contractAddress) {
    return DeployedContract(
      ContractAbi.fromJson(lemonadeEscrowFactoryV1ContractAbi, ''),
      EthereumAddress.fromHex(contractAddress),
    );
  }

  static DeployedContract getEscrowContract(String contractAddress) {
    return DeployedContract(
      ContractAbi.fromJson(lemonadeEscrowV1ContractAbi, ''),
      EthereumAddress.fromHex(contractAddress),
    );
  }

  static DeployedContract getRelayPaymentContract(String contractAddress) {
    return DeployedContract(
      ContractAbi.fromJson(lemonadeRelayPaymentContractAbi, ''),
      EthereumAddress.fromHex(contractAddress),
    );
  }

  static DeployedContract getPaymentSplitterContract(String contractAddress) {
    return DeployedContract(
      ContractAbi.fromJson(lemonadePaymentSplitterContractAbi, ''),
      EthereumAddress.fromHex(contractAddress),
    );
  }

  static DeployedContract getStakePaymentContract(String contractAddress) {
    return DeployedContract(
      ContractAbi.fromJson(lemonadeStakePaymentContractAbi, ''),
      EthereumAddress.fromHex(contractAddress),
    );
  }
}
