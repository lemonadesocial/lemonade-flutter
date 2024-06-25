import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_payment_input.freezed.dart';
part 'update_payment_input.g.dart';

@freezed
class UpdatePaymentInput with _$UpdatePaymentInput {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  factory UpdatePaymentInput({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'transfer_params')
    UpdatePaymentTransferParams? transferParams,
  }) = _UpdatePaymentInput;

  factory UpdatePaymentInput.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentInputFromJson(json);
}

@freezed
class UpdatePaymentTransferParams with _$UpdatePaymentTransferParams {
  @JsonSerializable(includeIfNull: false)
  factory UpdatePaymentTransferParams({
    @JsonKey(name: 'tx_hash') String? txHash,
    @JsonKey(name: 'signature') String? signature,
    // for stripe
    @JsonKey(name: 'payment_method') String? paymentMethod,
    String? network,
    String? from,
  }) = _UpdatePaymentTransferParams;

  factory UpdatePaymentTransferParams.fromJson(Map<String, dynamic> json) =>
      _$UpdatePaymentTransferParamsFromJson(json);
}
