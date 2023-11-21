// ignore_for_file: non_constant_identifier_names

import 'package:app/core/domain/web3/entities/chain_metadata.dart';
import 'package:app/gen/assets.gen.dart';

// TESTNET
final GOERLI = ChainMetadata(
  id: "5",
  chainId: "eip155:5",
  name: "goerli",
  displayName: "Ethereum Goerli",
  icon: Assets.icons.icEthereum.image(
    width: 18,
    height: 18,
  ),
  rpcUrl: "https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
  isTestnet: true,
  nativeCurrency: NativeCurrency(
    name: "Ethereum",
    symbol: "ETH",
    decimals: 18,
  ),
  blockExplorerForTransaction: (hash) => 'https://goerli.etherscan.io/tx/$hash',
);

final MUMBAI = ChainMetadata(
  id: "80001",
  chainId: "eip155:80001",
  name: "mumbai",
  displayName: "Mumbai",
  icon: Assets.icons.icPolygon.image(
    width: 18,
    height: 18,
  ),
  rpcUrl: "https://rpc-mumbai.maticvigil.com/",
  isTestnet: true,
  nativeCurrency: NativeCurrency(
    name: 'Matic Token',
    symbol: 'MATIC',
    decimals: 18,
  ),
  blockExplorerForTransaction: (hash) =>
      'https://mumbai.polygonscan.com/tx/$hash',
);

// MAINNET
final ETHEREUM = ChainMetadata(
  id: "1",
  chainId: "eip155:1",
  name: "ethereum",
  displayName: "Ethereum",
  icon: Assets.icons.icEthereum.image(
    width: 18,
    height: 18,
  ),
  rpcUrl: "https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
  nativeCurrency: NativeCurrency(
    name: "Ethereum",
    symbol: "ETH",
    decimals: 18,
  ),
  blockExplorerForTransaction: (hash) => 'https://etherscan.io/tx/$hash',
);

final POLYGON = ChainMetadata(
  id: "137",
  chainId: "eip155:137",
  name: "polygon",
  displayName: "Polygon",
  icon: Assets.icons.icPolygon.image(
    width: 18,
    height: 18,
  ),
  rpcUrl: "https://polygon-rpc.com/",
  nativeCurrency: NativeCurrency(
    name: "Matic Token",
    symbol: "MATIC",
    decimals: 18,
  ),
  blockExplorerForTransaction: (hash) => 'https://polygonscan.com/tx/$hash',
);

class Chains {
  static List<ChainMetadata> get testnet => [
        GOERLI,
        MUMBAI,
      ];

  static List<ChainMetadata> get mainnet => [
        ETHEREUM,
        POLYGON,
      ];

  static List<ChainMetadata> get allChains => [
        ...mainnet,
        ...testnet,
      ];
}
