import 'dart:math';

import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/cubejs/entities/cube_reward_use/cube_reward_use.dart';
import 'package:app/core/domain/event/entities/reward.dart';
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

Map<String, dynamic> getRewardUsesQuery({
  required List<String> rewardIds,
  DateTime? startDate,
  DateTime? endDate,
}) {
  final dateFormat = DateFormat(defaultDateFormat);
  final startDateFormatted = dateFormat.format(startDate ?? DateTime.now());
  final endDateFormatted = dateFormat.format(endDate ?? DateTime.now());
  final dateRange = [startDateFormatted, endDateFormatted];
  return {
    "measures": ["EventRewardUses.count"],
    "dimensions": ["EventRewardUses.rewardId"],
    "timeDimensions": [
      {
        "dimension": "EventRewardUses.updatedAt",
        "granularity": "day",
        "dateRange": dateRange,
      },
    ],
    "filters": [
      {
        "member": 'EventRewardUses.rewardId',
        "operator": 'contains',
        "values": rewardIds,
      }
    ],
  };
}

class InsightSamplingChart extends StatelessWidget {
  final String eventId;
  const InsightSamplingChart({
    super.key,
    required this.eventId,
  });

  int _calculateTotalRewardUses({required List<CubeRewardUse> rewardUses}) {
    final total = rewardUses.fold(0, (previousValue, element) {
      final useCount = element.count ?? 0;
      return useCount + previousValue;
    });
    return total;
  }

  String getRewardName({
    required List<Reward> rewards,
    required String rewardId,
  }) {
    return rewards
            .firstWhereOrNull((element) => element.id == rewardId)
            ?.title ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    final rewardIds =
        (event?.rewards ?? []).map((item) => item.id ?? '').toList();

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
            t.event.eventDashboard.insights.sampling,
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
              body: getRewardUsesQuery(
                // TODO: filter by reward Id
                rewardIds: rewardIds,
                startDate: timeRange.start,
                endDate: timeRange.end,
              ),
            ),
            builder: (context, snapshot) {
              final isLoading =
                  snapshot.connectionState == ConnectionState.waiting;
              final rewardUses = snapshot.data?.fold(
                    (l) => [].cast<CubeRewardUse>(),
                    (result) => result
                        .map((json) => CubeRewardUse.fromJson(json))
                        .toList(),
                  ) ??
                  [];
              final rewardUsesByDate = groupBy(
                rewardUses,
                (p) => DateFormat(defaultDateFormat).format(
                  p.updatedAt?.toLocal() ?? DateTime.now(),
                ),
              );
              final allDatesInRange = date_utils.DateUtils.generateDatesInRange(
                timeRange.start,
                timeRange.end,
              ).map((item) {
                return DateFormat(defaultDateFormat).format(item.toLocal());
              }).toList();

              final allRewardUsesByDateInRange =
                  allDatesInRange.fold<Map<String, List<CubeRewardUse>>>(
                {},
                (data, element) => data
                  ..putIfAbsent(element, () => rewardUsesByDate[element] ?? []),
              );

              final allDateKeys = allRewardUsesByDateInRange.keys.toList();

              final spots = allRewardUsesByDateInRange.entries
                  .map(
                    (entry) => FlSpot(
                      allDateKeys
                          .indexWhere((element) => element == entry.key)
                          .toDouble(),
                      _calculateTotalRewardUses(rewardUses: entry.value)
                          .toDouble(),
                    ),
                  )
                  .toList();
              final maxYInSpots =
                  spots.isEmpty ? 1 : spots.map((e) => e.y).reduce(max);
              return Stack(
                children: [
                  LemonLineChart(
                    lineVisible: rewardUses.isNotEmpty,
                    lineColor: LemonColor.coralReef,
                    data: spots,
                    minY: -0.5,
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
                            final allRewardUsesInDate =
                                allRewardUsesByDateInRange[dateKey] ?? [];
                            final rewardUsesByRewardId = groupBy(
                              allRewardUsesInDate,
                              (p0) => p0.rewardId,
                            );
                            final amountTexts =
                                rewardUsesByRewardId.entries.map((entry) {
                              final rewardTitle = getRewardName(
                                rewards: event?.rewards ?? [],
                                rewardId: entry.key ?? '',
                              );
                              final count = _calculateTotalRewardUses(
                                rewardUses: entry.value,
                              );
                              return '$rewardTitle: $count';
                            }).join('\n');
                            return LineTooltipItem(
                              '$dateKey \n',
                              Typo.xSmall.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                              children: [
                                if (allRewardUsesInDate.isNotEmpty)
                                  TextSpan(text: amountTexts),
                              ],
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                  if (rewardUses.isNotEmpty)
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
                              t.event.eventDashboard.insights.totalRedeemed,
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              _calculateTotalRewardUses(rewardUses: rewardUses)
                                  .toString(),
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (rewardUses.isEmpty || isLoading)
                    ChartEmptyMessage(
                      isLoading: isLoading,
                      title: t.event.eventDashboard.insights.totalRedeemed,
                      description: t.event.eventDashboard.insights
                          .noTotalRedeemedDescription,
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
