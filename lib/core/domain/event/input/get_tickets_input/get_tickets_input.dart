import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_tickets_input.freezed.dart';
part 'get_tickets_input.g.dart';

@freezed
class GetTicketsInput with _$GetTicketsInput {
  @JsonSerializable(includeIfNull: false)
  factory GetTicketsInput({
    @Default(0) int? skip,
    @Default(25) int? limit,
    List<String>? id,
    String? event,
    String? user,
  }) = _GetTicketsInput;

  factory GetTicketsInput.fromJson(Map<String, dynamic> json) =>
      _$GetTicketsInputFromJson(json);
}
