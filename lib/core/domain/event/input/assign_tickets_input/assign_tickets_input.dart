import 'package:freezed_annotation/freezed_annotation.dart';

part 'assign_tickets_input.freezed.dart';
part 'assign_tickets_input.g.dart';

@freezed
class AssignTicketsInput with _$AssignTicketsInput {
  factory AssignTicketsInput({
    required String event,
    required List<TicketAssignee> assignees,
  }) = _AssignTicketsInput;

  factory AssignTicketsInput.fromJson(Map<String, dynamic> json) =>
      _$AssignTicketsInputFromJson(json);
}

@freezed
class TicketAssignee with _$TicketAssignee {
  @Assert('email != null || user != null', 'At least email or user has value')
  factory TicketAssignee({
    required String ticket,
    String? email,
    String? user,
  }) = _TicketAssignee;

  factory TicketAssignee.fromJson(Map<String, dynamic> json) =>
      _$TicketAssigneeFromJson(json);
}
