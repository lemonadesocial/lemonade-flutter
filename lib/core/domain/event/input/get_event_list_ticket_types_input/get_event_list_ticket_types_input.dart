import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_list_ticket_types_input.freezed.dart';
part 'get_event_list_ticket_types_input.g.dart';

@freezed
class GetEventListTicketTypesInput with _$GetEventListTicketTypesInput {
  factory GetEventListTicketTypesInput({
    required String event,
    String? discount,
  }) = _GetEventListTicketTypesInput;

  factory GetEventListTicketTypesInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventListTicketTypesInputFromJson(json);
}
