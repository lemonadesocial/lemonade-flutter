import 'package:freezed_annotation/freezed_annotation.dart';

part 'redeem_tickets_input.freezed.dart';
part 'redeem_tickets_input.g.dart';

@freezed
class RedeemTicketsInput with _$RedeemTicketsInput {
  @JsonSerializable(explicitToJson: true)
  factory RedeemTicketsInput({
    required String event,
    required List<RedeemItem> items,
  }) = _RedeemTicketsInput;

  factory RedeemTicketsInput.fromJson(Map<String, dynamic> json) =>
      _$RedeemTicketsInputFromJson(json);
}

@freezed
class RedeemItem with _$RedeemItem {
  factory RedeemItem({
    required double count,
    @JsonKey(name: 'ticket_type') required String ticketType,
  }) = _RedeemItem;

  factory RedeemItem.fromJson(Map<String, dynamic> json) =>
      _$RedeemItemFromJson(json);
}
