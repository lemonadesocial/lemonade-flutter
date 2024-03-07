import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_payment_input.freezed.dart';
part 'get_payment_input.g.dart';

@freezed
class GetPaymentInput with _$GetPaymentInput {
  factory GetPaymentInput({
    required String id,
  }) = _GetPaymentInput;

  factory GetPaymentInput.fromJson(Map<String, dynamic> json) =>
      _$GetPaymentInputFromJson(json);
}
