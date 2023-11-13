import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_payment_input.freezed.dart';
part 'update_payment_input.g.dart';

@freezed
class UpdatePaymentInput with _$UpdatePaymentInput {
  @JsonSerializable(includeIfNull: false)
  factory UpdatePaymentInput({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'transfer_params') Map<String, dynamic>? transferParams,
  }) = _UpdatePaymentInput;

  factory UpdatePaymentInput.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentInputFromJson(json);
}
