import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_type_input.freezed.dart';

@freezed
class TicketPriceInput with _$TicketPriceInput {
  factory TicketPriceInput({
    required String currency,
    required String cost,
    bool? isDefault,
    List<String>? paymentAccounts,
  }) = _TicketPriceInput;
}
