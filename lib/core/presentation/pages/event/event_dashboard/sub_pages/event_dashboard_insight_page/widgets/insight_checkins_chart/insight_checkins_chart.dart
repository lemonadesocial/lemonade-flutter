import 'dart:math';

import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/cubejs/entities/cube_track/cube_track.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/chart_date_range_builder/chart_date_range_builder.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/chart_date_range_builder/chart_date_range_picker.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/chart_empty_message/chart_empty_message.dart';
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

    return ChartDateRangeBuilder(
      startDate: event?.start,
      endDate: event?.start?.add(
        const Duration(days: 30),
      ),
      builder: (
        timeRange, {
        required selectStartDate,
        required selectEndDate,
      }) =>
          Column(
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
          Row(
            children: [
              ChartDateRangePicker(
                timeRange: timeRange,
                onSelectEndDate: selectEndDate,
                onSelectStartDate: selectStartDate,
              ),
            ],
          ),
          SizedBox(height: Spacing.smMedium),
          FutureBuilder(
            future: CubeJsService(eventId: eventId).query(
              body: getCheckinsQuery(
                eventStartDate: event?.start ?? DateTime.now(),
                startDate: timeRange.start,
                endDate: timeRange.end,
              ),
            ),
            builder: (context, snapshot) {
              final isLoading =
                  snapshot.connectionState == ConnectionState.waiting;
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
                timeRange.start,
                timeRange.end,
              ).map((item) {
                return DateFormat(defaultDateFormat).format(item.toLocal());
              }).toList();

              final allTracksByDateInRange =
                  allDatesInRange.fold<Map<String, List<CubeTrackMember>>>(
                {},
                (data, element) => data
                  ..putIfAbsent(element, () => tracksByDate[element] ?? []),
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
              final maxYInSpots =
                  spots.isEmpty ? 1 : spots.map((e) => e.y).reduce(max);
              return Stack(
                children: [
                  LemonLineChart(
                    lineVisible: tracks.isNotEmpty,
                    lineColor: LemonColor.paleViolet,
                    data: spots,
                    minY: -0.1,
                    maxY: maxYInSpots * 1.5,
                    xTitlesWidget: (value, meta) => allDatesInRange.isNotEmpty
                        ? Text(
                            DateFormat(displayDateFormat).format(
                              DateTime.parse(allDatesInRange[value.toInt()]),
                            ),
                            style: Typo.small
                                .copyWith(color: colorScheme.onSecondary),
                          )
                        : const SizedBox.shrink(),
                    yTitlesWidget: (value, meta) {
                      if (value < 0) return const SizedBox.shrink();
                      return Text(
                        value.toStringAsFixed(1).toString(),
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
                                _calculateTotalCheckins(
                              tracks: allTracksInDate,
                            );
                            return LineTooltipItem(
                              '$dateKey \n',
                              Typo.xSmall.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                              children: [
                                TextSpan(
                                  text: totalTrackCountInDate.toString(),
                                ),
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
                  if (tracks.isEmpty || isLoading)
                    ChartEmptyMessage(
                      isLoading: isLoading,
                      title: t.event.eventDashboard.insights.totalCheckIns,
                      description: t.event.eventDashboard.insights
                          .noTotalCheckInsDescription,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
