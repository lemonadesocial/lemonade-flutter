import 'dart:math';

import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/cubejs/entities/cube_track/cube_track.dart';
import 'package:app/core/presentation/widgets/charts/line_chart/line_chart.dart';
import 'package:app/core/service/cubejs_service/cubejs_service.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

const defaultDateFormat = 'yyyy-MM-dd';
const displayDateFormat = 'dd-MMM';

Map<String, dynamic> getCheckinsQuery({
  required DateTime eventStartDate,
  DateTime? startDate,
  DateTime? endDate,
}) {
  final dateFormat = DateFormat(defaultDateFormat);
  final startDateFormatted = dateFormat.format(startDate ?? DateTime.now());
  final endDateFormatted = dateFormat.format(endDate ?? DateTime.now());
  final dateRange = [startDateFormatted, endDateFormatted];
  return {
    "measures": ["Tracks.countDistinctUsers"],
    "timeDimensions": [
      {
        "dimension": "Tracks.date",
        "granularity": "day",
        "dateRange": dateRange,
      },
    ],
    "filters": [
      {
        "member": 'Tracks.date',
        "operator": 'afterDate',
        "values": [dateFormat.format(eventStartDate)],
      }
    ],
  };
}

class InsightCheckinsChart extends StatelessWidget {
  final String eventId;
  const InsightCheckinsChart({
    super.key,
    required this.eventId,
  });

  int _calculateTotalCheckins({required List<CubeTrackMember> tracks}) {
    final total = tracks.fold(0, (previousValue, element) {
      final currentTrackCount =
          int.tryParse(element.countDistinctUsers ?? '0') ?? 0;
      return currentTrackCount + previousValue;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    // TODO: build date time range builder with default start end date of event
    final startDate = DateTime.parse('2024-02-01');
    final endDate = DateTime.parse('2024-04-17');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.eventDashboard.insights.checkIns,
          style: Typo.mediumPlus.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Spacing.smMedium),
        FutureBuilder(
          future: CubeJsService(eventId: eventId).query(
            body: getCheckinsQuery(
              eventStartDate: event?.start ?? DateTime.now(),
              startDate: startDate,
              endDate: endDate,
            ),
          ),
          builder: (context, snapshot) {
            final tracks = snapshot.data?.fold(
                  (l) => [].cast<CubeTrackMember>(),
                  (result) => result
                      .map((json) => CubeTrackMember.fromJson(json))
                      .toList(),
                ) ??
                [];
            final tracksByDate = groupBy(
              tracks,
              (p) => DateFormat(defaultDateFormat).format(
                p.date?.toLocal() ?? DateTime.now(),
              ),
            );
            final allDatesInRange = date_utils.DateUtils.generateDatesInRange(
              startDate,
              endDate,
            ).map((item) {
              return DateFormat(defaultDateFormat).format(item.toLocal());
            }).toList();

            final allTracksByDateInRange =
                allDatesInRange.fold<Map<String, List<CubeTrackMember>>>(
              {},
              (data, element) =>
                  data..putIfAbsent(element, () => tracksByDate[element] ?? []),
            );

            final allDateKeys = allTracksByDateInRange.keys.toList();

            final spots = allTracksByDateInRange.entries
                .map(
                  (entry) => FlSpot(
                    allDateKeys
                        .indexWhere((element) => element == entry.key)
                        .toDouble(),
                    _calculateTotalCheckins(tracks: entry.value).toDouble(),
                  ),
                )
                .toList();
            final maxYInSpots = spots.map((e) => e.y).reduce(max);
            return Stack(
              children: [
                LemonLineChart(
                  lineVisible: tracks.isNotEmpty,
                  lineColor: LemonColor.paleViolet,
                  data: spots,
                  minY: -0.5,
                  maxY: maxYInSpots * 1.5,
                  xTitlesWidget: (value, meta) => Text(
                    DateFormat(displayDateFormat).format(
                      DateTime.parse(allDatesInRange[value.toInt()]),
                    ),
                    style: Typo.small.copyWith(color: colorScheme.onSecondary),
                  ),
                  yTitlesWidget: (value, meta) {
                    if (value < 0) return const SizedBox.shrink();
                    return Text(
                      value.toInt().toString(),
                      style:
                          Typo.small.copyWith(color: colorScheme.onSecondary),
                    );
                  },
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => LemonColor.atomicBlack,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((item) {
                          final dateKey = allDateKeys[item.x.toInt()];
                          final allTracksInDate =
                              allTracksByDateInRange[dateKey] ?? [];
                          final totalTrackCountInDate =
                              _calculateTotalCheckins(tracks: allTracksInDate);
                          return LineTooltipItem(
                            '$dateKey \n',
                            Typo.xSmall.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                            children: [
                              TextSpan(text: totalTrackCountInDate.toString()),
                            ],
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.smMedium,
                      horizontal: Spacing.smMedium,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          t.event.eventDashboard.insights.totalCheckIns,
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          _calculateTotalCheckins(tracks: tracks).toString(),
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
