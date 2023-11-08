import 'package:app/core/domain/payment/payment_enums.dart';
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
    List<Currency>? currencies,
    @JsonKey(name: 'currency_map') dynamic currencyMap,
    @JsonKey(name: 'account_id') String? accountId,
    // Blockchain
    String? address,
    String? network,
    // Stripe
    @JsonKey(name: 'publishable_key') String? publishableKey,
  }) = _AccountInfoDto;

  factory AccountInfoDto.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoDtoFromJson(json);
}
