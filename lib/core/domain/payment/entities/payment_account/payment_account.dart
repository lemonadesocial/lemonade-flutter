import 'package:app/core/data/payment/dtos/payment_account_dto/payment_account_dto.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_account.freezed.dart';

@freezed
class PaymentAccount with _$PaymentAccount {
  PaymentAccount._();

  factory PaymentAccount({
    String? id,
    bool? active,
    DateTime? createdAt,
    String? user,
    PaymentAccountType? type,
    PaymentProvider? provider,
    AccountInfo? accountInfo,
  }) = _PaymentAccount;

  factory PaymentAccount.fromDto(PaymentAccountDto dto) => PaymentAccount(
        id: dto.id,
        active: dto.active,
        createdAt: dto.createdAt,
        type: dto.type,
        provider: dto.provider,
        accountInfo: dto.accountInfo != null
            ? AccountInfo.fromDto(dto.accountInfo!)
            : null,
      );
}

@freezed
class AccountInfo with _$AccountInfo {
  AccountInfo._();

  factory AccountInfo({
    List<Currency>? currencies,
    Map<Currency, CurrencyInfo>? currencyMap,
    String? accountId,
    // Blockchain
    String? address,
    List<SupportedPaymentNetwork>? networks,
    // Stripe
    String? publishableKey,
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
        address: dto.address,
        networks: dto.networks,
        publishableKey: dto.publishableKey,
      );
}

@freezed
class CurrencyInfo with _$CurrencyInfo {
  CurrencyInfo._();

  factory CurrencyInfo({
    int? decimals,
    Map<SupportedPaymentNetwork, String>? contracts,
  }) = _CurrencyInfo;

  factory CurrencyInfo.fromDto(CurrencyInfoDto dto) => CurrencyInfo(
        decimals: dto.decimals,
        contracts: dto.contracts,
      );
}
