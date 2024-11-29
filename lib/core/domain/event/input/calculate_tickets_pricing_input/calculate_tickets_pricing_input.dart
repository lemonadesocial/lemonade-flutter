import 'package:app/core/domain/payment/entities/purchasable_item/purchasable_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculate_tickets_pricing_input.freezed.dart';
part 'calculate_tickets_pricing_input.g.dart';

@freezed
class CalculateTicketsPricingInput with _$CalculateTicketsPricingInput {
  @JsonSerializable(includeIfNull: false)
  factory CalculateTicketsPricingInput({
    @JsonKey(name: 'event') required String eventId,
    required String currency,
    String? discount,
    @Default([]) List<PurchasableItem> items,
  }) = _CalculateTicketsPricingInput;

  factory CalculateTicketsPricingInput.fromJson(Map<String, dynamic> json) =>
      _$CalculateTicketsPricingInputFromJson(json);
}
