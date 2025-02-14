import 'package:app/core/data/event/dtos/ticket_statistics_dto/ticket_statistics_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_statistics.freezed.dart';
part 'ticket_statistics.g.dart';

@freezed
class TicketStatistics with _$TicketStatistics {
  factory TicketStatistics({
    double? all,
    double? checkedIn,
    double? invited,
    double? issued,
    double? cancelled,
    double? notCheckedIn,
    List<JoinRequestStatistic>? applicants,
    List<TicketStatisticPerTier>? ticketTypes,
  }) = _TicketStatistics;

  factory TicketStatistics.fromDto(TicketStatisticsDto dto) => TicketStatistics(
        all: dto.all,
        checkedIn: dto.checkedIn,
        invited: dto.invited,
        issued: dto.issued,
        cancelled: dto.cancelled,
        notCheckedIn: dto.notCheckedIn,
        applicants: dto.applicants
            ?.map((e) => JoinRequestStatistic.fromDto(e))
            .toList(),
        ticketTypes: dto.ticketTypes
            ?.map((e) => TicketStatisticPerTier.fromDto(e))
            .toList(),
      );

  factory TicketStatistics.fromJson(Map<String, dynamic> json) =>
      _$TicketStatisticsFromJson(json);
}

@freezed
class JoinRequestStatistic with _$JoinRequestStatistic {
  factory JoinRequestStatistic({
    required Enum$EventJoinRequestState state,
    required double count,
  }) = _JoinRequestStatistic;

  factory JoinRequestStatistic.fromDto(JoinRequestStatisticDto dto) =>
      JoinRequestStatistic(
        state: dto.state,
        count: dto.count,
      );

  factory JoinRequestStatistic.fromJson(Map<String, dynamic> json) =>
      _$JoinRequestStatisticFromJson(json);
}

@freezed
class TicketStatisticPerTier with _$TicketStatisticPerTier {
  factory TicketStatisticPerTier({
    required String ticketType,
    required String ticketTypeTitle,
    required double count,
  }) = _TicketStatisticPerTier;

  factory TicketStatisticPerTier.fromDto(TicketStatisticPerTierDto dto) =>
      TicketStatisticPerTier(
        ticketType: dto.ticketType,
        ticketTypeTitle: dto.ticketTypeTitle,
        count: dto.count,
      );

  factory TicketStatisticPerTier.fromJson(Map<String, dynamic> json) =>
      _$TicketStatisticPerTierFromJson(json);
}
