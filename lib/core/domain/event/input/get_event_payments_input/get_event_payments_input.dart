import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_payments_input.freezed.dart';
part 'get_event_payments_input.g.dart';

@freezed
class GetEventPaymentsInput with _$GetEventPaymentsInput {
  @JsonSerializable(includeIfNull: false)
  factory GetEventPaymentsInput({
    String? user,
    String? event,
    @JsonKey(name: 'ticket_assignees') String? ticketAssignees,
  }) = _GetEventPaymentsInput;

  factory GetEventPaymentsInput.fromJson(Map<String, dynamic> json) =>
      _$GetEventPaymentsInputFromJson(json);
}
