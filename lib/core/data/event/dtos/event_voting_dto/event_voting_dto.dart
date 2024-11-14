import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_voting_dto.freezed.dart';
part 'event_voting_dto.g.dart';

@freezed
class EventVotingDto with _$EventVotingDto {
  const factory EventVotingDto({
    @JsonKey(name: '_id') String? id,
    String? description,
    DateTime? end,
    bool? hidden,
    @JsonKey(name: 'selected_option') String? selectedOption,
    List<UserDto>? speakers,
    String? stage,
    DateTime? start,
    Enum$EventVotingState? state,
    String? timezone,
    String? title,
    @JsonKey(name: 'voting_options') List<VotingOptionDto>? votingOptions,
  }) = _EventVotingDto;

  factory EventVotingDto.fromJson(Map<String, dynamic> json) =>
      _$EventVotingDtoFromJson(json);
}

@freezed
class VotingOptionDto with _$VotingOptionDto {
  const factory VotingOptionDto({
    @JsonKey(name: 'option_id') String? optionId,
    List<UserDto>? voters,
  }) = _VotingOptionDto;

  factory VotingOptionDto.fromJson(Map<String, dynamic> json) =>
      _$VotingOptionDtoFromJson(json);
}
