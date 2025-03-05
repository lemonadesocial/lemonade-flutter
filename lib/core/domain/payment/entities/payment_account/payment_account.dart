import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/core/domain/payment/entities/refund_policy/refund_policy.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_account.freezed.dart';
part 'payment_account.g.dart';

@freezed
class PaymentAccount with _$PaymentAccount {
  PaymentAccount._();

  @JsonSerializable(explicitToJson: true)
  factory PaymentAccount({
    String? id,
    bool? active,
    DateTime? createdAt,
    String? user,
    String? title,
    PaymentAccountType? type,
    PaymentProvider? provider,
    AccountInfo? accountInfo,
    // EthereumRelay
    String? fee,
    BigInt? cryptoFee,
    double? fiatFee,
    Relay? relay,
  }) = _PaymentAccount;

  factory PaymentAccount.fromDto(PaymentAccountDto dto) => PaymentAccount(
        id: dto.id,
        active: dto.active,
        createdAt: dto.createdAt,
        title: dto.title,
        type: dto.type,
        provider: dto.provider,
        accountInfo: dto.accountInfo != null
            ? AccountInfo.fromDto(dto.accountInfo!)
            : null,
        fee: dto.fee,
        fiatFee: dto.fee != null ? double.parse(dto.fee!) : null,
        cryptoFee: dto.fee != null ? BigInt.parse(dto.fee!) : null,
        relay: dto.relay != null ? Relay.fromDto(dto.relay!) : null,
      );

  factory PaymentAccount.fromJson(Map<String, dynamic> json) =>
      _$PaymentAccountFromJson(json);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentAccount &&
            other.id == id &&
            other.accountInfo?.toString() == accountInfo?.toString());
  }

  @override
  int get hashCode => Object.hash(
        id,
        active,
        createdAt,
        user,
        title,
        type,
        provider,
        accountInfo,
        fee,
        cryptoFee,
        fiatFee,
        relay,
      );
}

@freezed
class AccountInfo with _$AccountInfo {
  AccountInfo._();

  @JsonSerializable(explicitToJson: true)
  factory AccountInfo({
    List<String>? currencies,
    Map<String, CurrencyInfo>? currencyMap,
    String? accountId,
    // Blockchain
    String? address,
    List<String>? networks,
    // Safe | EthereumRelay | EthereumEscrow
    String? network,
    // Safe
    List<String>? owners,
    int? threshold,
    bool? pending,
    // Stripe
    String? publishableKey,
    // Escrow
    int? minimumDepositPercent,
    double? hostRefundPercent,
    List<RefundPolicy>? refundPolicies,
    // Safe | EthereumRelay | EthereumEscrow
    String? paymentSplitterContract,
    // EthereumStake
    String? configId,
    DateTime? requirementCheckinBefore,
  }) = _AccountInfo;

  factory AccountInfo.fromDto(AccountInfoDto dto) => AccountInfo(
        currencies: dto.currencies,
        currencyMap: Map.fromEntries(
          (dto.currencyMap?.entries ?? []).map(
            (e) => MapEntry(
              e.key,
              CurrencyInfo.fromDto(e.value),
            ),
          ),
        ),
        accountId: dto.accountId,
        // blockchain account
        address: dto.address,
        networks: dto.networks,
        // Safe | EthereumRelay | EthereumEscrow
        network: dto.network,
        // Safe
        owners: dto.owners,
        threshold: dto.threshold,
        pending: dto.pending,
        // Stripe
        publishableKey: dto.publishableKey,
        // escrow
        minimumDepositPercent: dto.minimumDepositPercent,
        hostRefundPercent: dto.hostRefundPercent,
        refundPolicies: (dto.refundPolicies ?? [])
            .map((item) => RefundPolicy.fromDto(item))
            .toList(),
        // EthereumRelay
        paymentSplitterContract: dto.paymentSplitterContract,
        // EthereumStake
        configId: dto.configId,
        requirementCheckinBefore: dto.requirementCheckinBefore,
      );

  factory AccountInfo.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoFromJson(json);
}

@freezed
class CurrencyInfo with _$CurrencyInfo {
  CurrencyInfo._();

  factory CurrencyInfo({
    int? decimals,
    Map<String, String>? contracts,
  }) = _CurrencyInfo;

  factory CurrencyInfo.fromDto(CurrencyInfoDto dto) => CurrencyInfo(
        decimals: dto.decimals,
        contracts: dto.contracts,
      );
  factory CurrencyInfo.fromJson(Map<String, dynamic> json) =>
      _$CurrencyInfoFromJson(json);
}

@freezed
class Relay with _$Relay {
  Relay._();

  factory Relay({
    String? paymentSplitterContract,
  }) = _Relay;

  factory Relay.fromDto(RelayDto dto) => Relay(
        paymentSplitterContract: dto.paymentSplitterContract,
      );

  factory Relay.fromJson(Map<String, dynamic> json) => _$RelayFromJson(json);
}
