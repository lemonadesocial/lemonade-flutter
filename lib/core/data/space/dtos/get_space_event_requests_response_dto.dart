import 'package:app/core/data/space/dtos/space_event_request_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_space_event_requests_response_dto.freezed.dart';
part 'get_space_event_requests_response_dto.g.dart';

@freezed
class GetSpaceEventRequestsResponseDto with _$GetSpaceEventRequestsResponseDto {
  const factory GetSpaceEventRequestsResponseDto({
    @JsonKey(name: 'total') int? total,
    @JsonKey(name: 'records') List<SpaceEventRequestDto>? records,
  }) = _GetSpaceEventRequestsResponseDto;

  factory GetSpaceEventRequestsResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetSpaceEventRequestsResponseDtoFromJson(json);
}
