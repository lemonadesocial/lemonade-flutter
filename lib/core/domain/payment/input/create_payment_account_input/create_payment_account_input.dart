import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_payment_account_input.freezed.dart';
part 'create_payment_account_input.g.dart';

@freezed
class CreatePaymentAccountInput with _$CreatePaymentAccountInput {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  factory CreatePaymentAccountInput({
    required PaymentAccountType type,
    String? title,
    PaymentProvider? provider,
    @JsonKey(name: 'account_info') AccountInfoInput? accountInfo,
  }) = _CreatePaymentAccountInput;

  factory CreatePaymentAccountInput.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentAccountInputFromJson(json);
}

@freezed
class AccountInfoInput with _$AccountInfoInput {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  factory AccountInfoInput({
    // Common
    @Default([]) List<String>? currencies,
    // Blockchain Account
    String? address,
    // Ethereum only
    @JsonKey(name: 'networks') List<String>? ethereumPaymentAccountNetworks,
    // Safe Account extends Blockchain Account
    String? network,
    List<String>? owners,
    int? threshold,
    // Ethereum Relay
    @JsonKey(name: 'payment_splitter_contract') String? paymentSplitterContract,
    // Ethereum Stake
    @JsonKey(name: 'config_id') String? configId,
    @JsonKey(name: 'requirement_checkin_before')
    DateTime? requirementCheckinBefore,
  }) = _AccountInfoInput;

  factory AccountInfoInput.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoInputFromJson(json);
}
