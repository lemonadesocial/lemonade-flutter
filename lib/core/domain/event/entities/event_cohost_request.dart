import 'package:app/core/data/event/dtos/event_cohost_request_dto/event_cohost_request_dto.dart';
import 'package:app/core/domain/user/entities/user.dart';

class EventCohostRequest {
  EventCohostRequest({
    this.id,
    this.toExpanded,
  });

  String? id;
  User? toExpanded;

  factory EventCohostRequest.fromDto(EventCohostRequestDto dto) =>
      EventCohostRequest(
        id: dto.id,
        toExpanded:
            dto.toExpanded != null ? User.fromDto(dto.toExpanded!) : null,
      );
}
