import 'package:app/core/data/event/dtos/generate_event_invitation_url_response_dto/generate_event_invitation_url_response_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_event_invitation_url_response.freezed.dart';
part 'generate_event_invitation_url_response.g.dart';

@freezed
class GenerateEventInvitationUrlResponse
    with _$GenerateEventInvitationUrlResponse {
  factory GenerateEventInvitationUrlResponse({
    String? shortid,
    String? tk,
  }) = _GenerateEventInvitationUrlResponse;

  factory GenerateEventInvitationUrlResponse.fromDto(
    GenerateEventInvitationUrlResponseDto dto,
  ) =>
      GenerateEventInvitationUrlResponse(
        shortid: dto.shortid,
        tk: dto.tk,
      );
  factory GenerateEventInvitationUrlResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GenerateEventInvitationUrlResponseFromJson(json);
}
