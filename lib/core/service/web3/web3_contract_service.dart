import 'package:app/core/service/web3/ERC20.dart';
import 'package:web3dart/web3dart.dart';

class Web3ContractService {
  static DeployedContract getERC20Contract(String contractAddress) {
    return DeployedContract(
      ContractAbi.fromJson(erc20Abi, ''),
      EthereumAddress.fromHex(contractAddress),
    );
  }
}
