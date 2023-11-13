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
    dynamic currencyMap,
    String? accountId,
    // Blockchain
    String? address,
    String? network,
    // Stripe
    String? publishableKey,
  }) = _AccountInfo;

  factory AccountInfo.fromDto(AccountInfoDto dto) => AccountInfo(
        currencies: dto.currencies,
        currencyMap: dto.currencyMap,
        accountId: dto.accountId,
        address: dto.address,
        network: dto.network,
        publishableKey: dto.publishableKey,
      );
}
