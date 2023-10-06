import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_ticket_types_input.freezed.dart';
part 'get_event_ticket_types_input.g.dart';

@freezed
class GetEventTicketTypesInput with _$GetEventTicketTypesInput {
  factory GetEventTicketTypesInput({
    required String event,
    @JsonSerializable(includeIfNull: false) String? discount,
  }) = _GetEventTicketTypesInput;

  factory GetEventTicketTypesInput.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetEventTicketTypesInputFromJson(json);
}
