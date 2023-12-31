import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_cohost_request.freezed.dart';
part 'event_cohost_request.g.dart';

@freezed
class EventCohostRequest with _$EventCohostRequest {
  @JsonSerializable(explicitToJson: true)
  factory EventCohostRequest({
    String? id,
    UserDto? toExpanded,
  }) = _EventCohostRequest;

  factory EventCohostRequest.fromJson(Map<String, dynamic> json) =>
      _$EventCohostRequestFromJson(json);
}
