import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_ticket_pricing_input.g.dart';
part 'get_event_ticket_pricing_input.freezed.dart';

@freezed
class GetEventTicketPricingInput with _$GetEventTicketPricingInput {
  @JsonSerializable(includeIfNull: false)
  factory GetEventTicketPricingInput({
    required String event,
    String? type,
    String? discount,
  }) = _GetEventTicketPricingInput;

  factory GetEventTicketPricingInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventTicketPricingInputFromJson(json);
}
