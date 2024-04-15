import 'package:app/core/data/event/dtos/event_cohost_request_dto/event_cohost_request_dto.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_cohost_request.freezed.dart';

@freezed
class EventCohostRequest with _$EventCohostRequest {
  factory EventCohostRequest({
    String? id,
    User? toExpanded,
    EventCohostRequestState? state,
  }) = _EventCohostRequest;

  factory EventCohostRequest.fromDto(EventCohostRequestDto dto) =>
      EventCohostRequest(
        id: dto.id,
        toExpanded:
            dto.toExpanded != null ? User.fromDto(dto.toExpanded!) : null,
        state: dto.state,
      );
}
