import 'package:app/core/data/web3/dtos/chain_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain.freezed.dart';

@freezed
class Chain with _$Chain {
  factory Chain({
    bool? active,
    String? chainId,
    String? fullChainId,
    String? name,
    String? rpcUrl,
    String? logoUrl,
    List<ERC20Token>? tokens,
  }) = _Chain;

  factory Chain.fromDto(ChainDto dto) => Chain(
        active: dto.active,
        chainId: dto.chainId,
        // Ethereum based
        fullChainId: 'eip155:${dto.chainId}',
        name: dto.name,
        rpcUrl: dto.rpcUrl,
        logoUrl: dto.logoUrl,
        tokens: List.from(dto.tokens ?? [])
            .map((item) => ERC20Token.fromDto(item))
            .toList(),
      );
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
  }) = _ERC20Token;

  factory ERC20Token.fromDto(ERC20TokenDto dto) => ERC20Token(
        name: dto.name,
        active: dto.active,
        symbol: dto.symbol,
        decimals: dto.decimals,
        contract: dto.contract,
      );
}
