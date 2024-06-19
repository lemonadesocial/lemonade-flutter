import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_tickets_input.g.dart';
part 'buy_tickets_input.freezed.dart';

@freezed
class BuyTicketsInput with _$BuyTicketsInput {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  factory BuyTicketsInput({
    @JsonKey(name: 'event') required String eventId,
    @JsonKey(name: 'account_id') required String accountId,
    required String currency,
    String? network,
    required String total,
    required List<PurchasableItem>? items,
    @JsonKey(name: 'billing_info') BillingInfoInput? billingInfo,
    String? discount,
    @JsonKey(name: 'transfer_params')
    BuyTicketsTransferParamsInput? transferParams,
    // EthereumRelay
    String? fee,
  }) = _BuyTicketsInput;

  factory BuyTicketsInput.fromJson(Map<String, dynamic> json) =>
      _$BuyTicketsInputFromJson(json);
}

@freezed
class BillingInfoInput with _$BillingInfoInput {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory BillingInfoInput({
    String? street1,
    String? street2,
    String? city,
    String? region,
    String? postal,
    String? country,
    String? title,
    double? latitude,
    double? longitude,
    String? recipientName,
    @JsonKey(name: 'firstname') String? firstName,
    @JsonKey(name: 'lastname') String? lastName,
    String? phone,
  }) = _BillingInfoInput;

  factory BillingInfoInput.fromJson(Map<String, dynamic> json) =>
      _$BillingInfoInputFromJson(json);
}

@freezed
class BuyTicketsTransferParamsInput with _$BuyTicketsTransferParamsInput {
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  factory BuyTicketsTransferParamsInput({
    @JsonKey(name: 'save_card') bool? saveCard,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    String? network,
  }) = _BuyTicketsTransferParamsInput;

  factory BuyTicketsTransferParamsInput.fromJson(Map<String, dynamic> json) =>
      _$BuyTicketsTransferParamsInputFromJson(json);
}
