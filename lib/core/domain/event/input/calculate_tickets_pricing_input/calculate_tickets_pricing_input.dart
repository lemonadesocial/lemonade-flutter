import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculate_tickets_pricing_input.freezed.dart';
part 'calculate_tickets_pricing_input.g.dart';

@freezed
class CalculateTicketsPricingInput with _$CalculateTicketsPricingInput {
  factory CalculateTicketsPricingInput({
    @JsonKey(name: 'event') required String eventId,
    required Currency currency,
    String? discount,
    @Default([]) List<PurchasableItem> items,
  }) = _CalculateTicketsPricingInput;

  factory CalculateTicketsPricingInput.fromJson(Map<String, dynamic> json) =>
      _$CalculateTicketsPricingInputFromJson(json);
}
