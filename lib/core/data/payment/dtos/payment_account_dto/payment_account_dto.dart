import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/vault/vault_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_account_dto.freezed.dart';
part 'payment_account_dto.g.dart';

@freezed
class PaymentAccountDto with _$PaymentAccountDto {
  factory PaymentAccountDto({
    @JsonKey(name: '_id') String? id,
    bool? active,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    String? user,
    String? title,
    PaymentAccountType? type,
    PaymentProvider? provider,
    @JsonKey(name: 'account_info') AccountInfoDto? accountInfo,
  }) = _PaymentAccountDto;

  factory PaymentAccountDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentAccountDtoFromJson(json);
}

@freezed
class AccountInfoDto with _$AccountInfoDto {
  factory AccountInfoDto({
    List<String>? currencies,
    @JsonKey(name: 'currency_map') Map<String, CurrencyInfoDto>? currencyMap,
    @JsonKey(name: 'account_id') String? accountId,
    // Blockchain
    String? address,
    List<String>? networks,
    // Safe
    String? network,
    List<String>? owners,
    int? threshold,
    bool? pending,
    // Stripe
    @JsonKey(name: 'publishable_key') String? publishableKey,
  }) = _AccountInfoDto;

  factory AccountInfoDto.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoDtoFromJson(json);
}

@freezed
class CurrencyInfoDto with _$CurrencyInfoDto {
  factory CurrencyInfoDto({
    // crypto
    int? decimals,
    Map<String, String>? contracts,
  }) = _CurrencyInfoDto;

  factory CurrencyInfoDto.fromJson(Map<String, dynamic> json) =>
      _$CurrencyInfoDtoFromJson(json);
}
