import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_payment_accounts_input.freezed.dart';
part 'get_payment_accounts_input.g.dart';

@freezed
class GetPaymentAccountsInput with _$GetPaymentAccountsInput {
  factory GetPaymentAccountsInput({
    @Default(0) int? skip,
    @Default(25) int? limit,
    List<String>? id,
    PaymentAccountType? type,
    PaymentProvider? provider,
  }) = _GetPaymentAccountsInput;

  factory GetPaymentAccountsInput.fromJson(Map<String, dynamic> json) =>
      _$GetPaymentAccountsInputFromJson(json);
}
