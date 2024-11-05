import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_event_invitation_url_response_dto.freezed.dart';
part 'generate_event_invitation_url_response_dto.g.dart';

@freezed
class GenerateEventInvitationUrlResponseDto
    with _$GenerateEventInvitationUrlResponseDto {
  @JsonSerializable(explicitToJson: true)
  factory GenerateEventInvitationUrlResponseDto({
    String? shortid,
    String? tk,
  }) = _GenerateEventInvitationUrlResponseDto;

  factory GenerateEventInvitationUrlResponseDto.fromJson(
          Map<String, dynamic> json) =>
      _$GenerateEventInvitationUrlResponseDtoFromJson(json);
}
