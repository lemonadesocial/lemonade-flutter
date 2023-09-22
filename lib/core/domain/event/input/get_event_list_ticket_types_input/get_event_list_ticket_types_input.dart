import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_list_ticket_types_input.freezed.dart';
part 'get_event_list_ticket_types_input.g.dart';

@freezed
class GetEventListTicketTypesResponseInput
    with _$GetEventListTicketTypesResponseInput {
  factory GetEventListTicketTypesResponseInput({
    required String event,
    @JsonSerializable(includeIfNull: false) String? discount,
  }) = _GetEventListTicketTypesResponseInput;

  factory GetEventListTicketTypesResponseInput.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetEventListTicketTypesResponseInputFromJson(json);
}
