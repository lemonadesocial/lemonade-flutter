import 'package:freezed_annotation/freezed_annotation.dart';

part 'redeem_event_ticket_input.freezed.dart';
part 'redeem_event_ticket_input.g.dart';

@freezed
class RedeemEventTicketInput with _$RedeemEventTicketInput {
  @JsonSerializable(includeIfNull: false)
  factory RedeemEventTicketInput({
    required String id,
    required double count,
    String? type,
    String? address,
  }) = _RedeemEventTicketInput;

  factory RedeemEventTicketInput.fromJson(Map<String, dynamic> json) =>
      _$RedeemEventTicketInputFromJson(json);
}
