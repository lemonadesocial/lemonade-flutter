import 'package:app/core/data/space/dtos/get_space_event_requests_response_dto.dart';
import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_space_event_requests_response.freezed.dart';

@freezed
class GetSpaceEventRequestsResponse with _$GetSpaceEventRequestsResponse {
  const factory GetSpaceEventRequestsResponse({
    required int total,
    required List<SpaceEventRequest> records,
  }) = _GetSpaceEventRequestsResponse;

  factory GetSpaceEventRequestsResponse.fromDto(
    GetSpaceEventRequestsResponseDto dto,
  ) {
    return GetSpaceEventRequestsResponse(
      total: dto.total ?? 0,
      records: dto.records
              ?.map((record) => SpaceEventRequest.fromDto(record))
              .toList() ??
          [],
    );
  }
}
