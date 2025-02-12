import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain_dto.freezed.dart';
part 'chain_dto.g.dart';

@freezed
class ChainDto with _$ChainDto {
  factory ChainDto({
    bool? active,
    @JsonKey(name: 'chain_id') String? chainId,
    String? name,
    @JsonKey(name: 'rpc_url') String? rpcUrl,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'block_time') double? blockTime,
    @JsonKey(name: 'safe_confirmations') double? safeConfirmations,
    List<ERC20TokenDto>? tokens,
    @JsonKey(name: 'relay_payment_contract') String? relayPaymentContract,
    @JsonKey(name: 'stake_payment_contract') String? stakePaymentContract,
    @JsonKey(name: 'reward_registry_contract') String? rewardRegistryContract,
  }) = _ChainDto;

  factory ChainDto.fromJson(Map<String, dynamic> json) =>
      _$ChainDtoFromJson(json);
}

@freezed
class ERC20TokenDto with _$ERC20TokenDto {
  factory ERC20TokenDto({
    String? name,
    bool? active,
    String? symbol,
    double? decimals,
    String? contract,
    @JsonKey(name: 'logo_url') String? logoUrl,
  }) = _ERC20TokenDto;

  factory ERC20TokenDto.fromJson(Map<String, dynamic> json) =>
      _$ERC20TokenDtoFromJson(json);
}
