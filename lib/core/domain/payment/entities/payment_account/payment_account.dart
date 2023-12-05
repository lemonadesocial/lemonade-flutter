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
    String? title,
    PaymentAccountType? type,
    PaymentProvider? provider,
    AccountInfo? accountInfo,
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
      );
}

@freezed
class AccountInfo with _$AccountInfo {
  AccountInfo._();

  factory AccountInfo({
    List<String>? currencies,
    Map<String, CurrencyInfo>? currencyMap,
    String? accountId,
    // Blockchain
    String? address,
    List<String>? networks,
    // Safe extends Blockchain
    List<String>? owners,
    int? threshold,
    bool? funded,
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
        owners: dto.owners,
        threshold: dto.threshold,
        funded: dto.funded,
        publishableKey: dto.publishableKey,
      );
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
}
