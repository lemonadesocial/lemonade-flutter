import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_statistics_dto.freezed.dart';
part 'ticket_statistics_dto.g.dart';

@freezed
class TicketStatisticsDto with _$TicketStatisticsDto {
  factory TicketStatisticsDto({
    double? all,
    @JsonKey(name: 'checked_in') double? checkedIn,
    double? invited,
    double? issued,
    double? cancelled,
    @JsonKey(name: 'not_checked_in') double? notCheckedIn,
    List<JoinRequestStatisticDto>? applicants,
    @JsonKey(name: 'ticket_types') List<TicketStatisticPerTierDto>? ticketTypes,
  }) = _TicketStatisticsDto;

  factory TicketStatisticsDto.fromJson(Map<String, dynamic> json) =>
      _$TicketStatisticsDtoFromJson(json);
}

@freezed
class JoinRequestStatisticDto with _$JoinRequestStatisticDto {
  factory JoinRequestStatisticDto({
    @JsonKey(name: 'state') required Enum$EventJoinRequestState state,
    required double count,
  }) = _JoinRequestStatisticDto;

  factory JoinRequestStatisticDto.fromJson(Map<String, dynamic> json) =>
      _$JoinRequestStatisticDtoFromJson(json);
}

@freezed
class TicketStatisticPerTierDto with _$TicketStatisticPerTierDto {
  factory TicketStatisticPerTierDto({
    @JsonKey(name: 'ticket_type') required String ticketType,
    @JsonKey(name: 'ticket_type_title') required String ticketTypeTitle,
    required double count,
  }) = _TicketStatisticPerTierDto;

  factory TicketStatisticPerTierDto.fromJson(Map<String, dynamic> json) =>
      _$TicketStatisticPerTierDtoFromJson(json);
}
