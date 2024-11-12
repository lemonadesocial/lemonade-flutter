import 'package:app/core/data/event/dtos/event_voting_dto/event_voting_dto.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_voting.freezed.dart';

@freezed
class EventVoting with _$EventVoting {
  const factory EventVoting({
    String? id,
    String? description,
    DateTime? end,
    bool? hidden,
    String? selectedOption,
    List<User>? speakers,
    String? stage,
    DateTime? start,
    Enum$EventVotingState? state,
    String? timezone,
    String? title,
    List<VotingOption>? votingOptions,
  }) = _EventVoting;

  factory EventVoting.fromDto(EventVotingDto dto) => EventVoting(
        id: dto.id,
        description: dto.description,
        end: dto.end,
        hidden: dto.hidden,
        selectedOption: dto.selectedOption,
        speakers: (dto.speakers ?? []).map((s) => User.fromDto(s)).toList(),
        stage: dto.stage,
        start: dto.start,
        state: dto.state,
        timezone: dto.timezone,
        title: dto.title,
        votingOptions: (dto.votingOptions ?? [])
            .map((vo) => VotingOption.fromDto(vo))
            .toList(),
      );
}

@freezed
class VotingOption with _$VotingOption {
  const factory VotingOption({
    String? optionId,
    List<User>? voters,
  }) = _VotingOption;

  factory VotingOption.fromDto(VotingOptionDto dto) => VotingOption(
        optionId: dto.optionId,
        voters: (dto.voters ?? []).map((v) => User.fromDto(v)).toList(),
      );
}
