import 'package:app/core/constants/web3/chains.dart';
import 'package:app/core/data/web3/dtos/chain_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

part 'chain.freezed.dart';

@freezed
class Chain with _$Chain {
  Chain._();

  factory Chain({
    bool? active,
    String? chainId,
    String? fullChainId,
    String? name,
    String? rpcUrl,
    String? logoUrl,
    List<ERC20Token>? tokens,
    ERC20Token? nativeToken,
    double? blockTime,
    double? safeConfirmations,
    String? relayPaymentContract,
    String? stakePaymentContract,
    String? rewardRegistryContract,
    String? explorerUrl,
  }) = _Chain;

  int get completedBlockTime =>
      (blockTime?.toInt() ?? 1) * (safeConfirmations?.toInt() ?? 1);

  factory Chain.fromDto(ChainDto dto) {
    final tokens = List.from(dto.tokens ?? [])
        .map((item) => ERC20Token.fromDto(item))
        .toList();
    final nativeToken =
        tokens.firstWhereOrNull((token) => token.contract == zeroAddress);
    return Chain(
      active: dto.active,
      chainId: dto.chainId,
      // Ethereum based
      fullChainId: dto.chainId?.contains("solana") == true
          ? dto.chainId
          : 'eip155:${dto.chainId}',
      name: dto.name,
      rpcUrl: dto.rpcUrl,
      logoUrl: dto.logoUrl,
      tokens: tokens,
      nativeToken: nativeToken,
      blockTime: dto.blockTime,
      safeConfirmations: dto.safeConfirmations,
      relayPaymentContract: dto.relayPaymentContract,
      stakePaymentContract: dto.stakePaymentContract,
      rewardRegistryContract: dto.rewardRegistryContract,
    );
  }
}

@freezed
class ERC20Token with _$ERC20Token {
  ERC20Token._();

  factory ERC20Token({
    String? name,
    bool? active,
    String? symbol,
    double? decimals,
    String? contract,
    String? logoUrl,
  }) = _ERC20Token;

  factory ERC20Token.fromDto(ERC20TokenDto dto) => ERC20Token(
        name: dto.name,
        active: dto.active,
        symbol: dto.symbol,
        decimals: dto.decimals,
        contract: dto.contract,
        logoUrl: dto.logoUrl,
      );
}
