import 'package:app/core/domain/payment/input/create_payment_account_input/create_payment_account_input.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_payment_account_input.freezed.dart';
part 'update_payment_account_input.g.dart';

@freezed
class UpdatePaymentAccountInput with _$UpdatePaymentAccountInput {
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  factory UpdatePaymentAccountInput({
    @JsonKey(name: '_id') required String id,
    String? title,
    @JsonKey(name: 'account_info') AccountInfoInput? accountInfo,
  }) = _UpdatePaymentAccountInput;

  factory UpdatePaymentAccountInput.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentAccountInputFromJson(json);
}
