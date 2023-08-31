// ignore_for_file: non_constant_identifier_names

import 'package:app/core/domain/web3/entities/chain_metadata_entity.dart';

// TESTNET
final GOERLI = ChainMetadata(
  chainId: "eip155:5",
  name: "goerli",
  displayName: "Goerli",
  icon: "",
  rpcUrl: "https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
  isTestnet: true,
);

final MUMBAI = ChainMetadata(
  chainId: "eip155:80001",
  name: "mumbai",
  displayName: "Mumbai",
  icon: "",
  rpcUrl: "https://rpc-mumbai.maticvigil.com/",
  isTestnet: true,
);

// MAINNET
final ETHEREUM = ChainMetadata(
  chainId: "eip155:1",
  name: "ethereum",
  displayName: "Ethereum",
  icon: "",
  rpcUrl: "https://mainnet.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
);

final POLYGON = ChainMetadata(
  chainId: "eip155:137",
  name: "polygon",
  displayName: "POLYGON",
  icon: "",
  rpcUrl: "https://polygon-rpc.com/",
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
