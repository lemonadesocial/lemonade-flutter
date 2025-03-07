import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_events_to_space_response.freezed.dart';
part 'pin_events_to_space_response.g.dart';

@freezed
class PinEventsToSpaceResponse with _$PinEventsToSpaceResponse {
  const factory PinEventsToSpaceResponse({
    List<SpaceEventRequest>? requests,
  }) = _PinEventsToSpaceResponse;

  factory PinEventsToSpaceResponse.fromJson(Map<String, dynamic> json) =>
      _$PinEventsToSpaceResponseFromJson(json);
}
