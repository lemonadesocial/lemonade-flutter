import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculate_tickets_pricing_input.freezed.dart';
part 'calculate_tickets_pricing_input.g.dart';

@freezed
class CalculateTicketsPricingInput with _$CalculateTicketsPricingInput {
  factory CalculateTicketsPricingInput({
    @JsonKey(name: 'event') required String eventId,
    String? discount,
    @Default([]) List<PurchasableItem> items,
  }) = _CalculateTicketsPricingInput;

  factory CalculateTicketsPricingInput.fromJson(Map<String, dynamic> json) =>
      _$CalculateTicketsPricingInputFromJson(json);
}

@freezed
class PurchasableItem with _$PurchasableItem {
  factory PurchasableItem({
    required String id,
    required double count,
  }) = _PurchasableItem;

  factory PurchasableItem.fromJson(Map<String, dynamic> json) =>
      _$PurchasableItemFromJson(json);
}
