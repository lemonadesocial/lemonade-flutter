import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'buy_ticket_input.freezed.dart';

part 'buy_ticket_input.g.dart';

@freezed
class BuyTicketsInput with _$BuyTicketsInput {
  factory BuyTicketsInput({
    @JsonKey(name: 'event') required String eventId,
    double? discount,
    double? total,
    List<PurchasableItem>? items,
    @JsonKey(name: 'billing_info') BillingInfoInput? billingInfo,
  }) = _BuyTicketsInput;
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
    String? firstname,
    String? lastname,
    String? phone,
  }) = _BillingInfoInput;

  factory BillingInfoInput.fromJson(Map<String, dynamic> json) =>
      _$BillingInfoInputFromJson(json);
}
