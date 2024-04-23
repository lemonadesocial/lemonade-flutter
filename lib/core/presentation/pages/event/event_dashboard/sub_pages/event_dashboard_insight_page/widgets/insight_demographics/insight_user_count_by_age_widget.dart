import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_demographics/demographics_placeholder.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/graphql/cubejs/query/get_user_count_by_dimensions.graphql.dart';
import 'package:app/graphql/cubejs/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InsightUserCountByAgeWidget extends StatelessWidget {
  final String eventId;
  const InsightUserCountByAgeWidget({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Query$GetAllEventAccepted$Widget(
      options: Options$Query$GetAllEventAccepted(
        fetchPolicy: FetchPolicy.noCache,
      ),
      builder: (allAcceptedResult, {fetchMore, refetch}) {
        return Query$GetEventAcceptedByAgeGroup$Widget(
          options: Options$Query$GetEventAcceptedByAgeGroup(
            variables: Variables$Query$GetEventAcceptedByAgeGroup(
              limit: 5,
              where: Input$EventsAcceptedWhereInput(
                count: Input$FloatFilter(gt: 0),
              ),
            ),
            fetchPolicy: FetchPolicy.noCache,
          ),
          builder: (result, {refetch, fetchMore}) {
            final totalAccepted = allAcceptedResult
                    .parsedData?.cube.firstOrNull?.eventsAccepted.count ??
                1;
            final allItems = result.parsedData?.cube ?? [];
            final allItemEntries = allItems.asMap().entries.toList();
            final isLoading = allAcceptedResult.isLoading || result.isLoading;
            return AnimatedSize(
              duration: const Duration(milliseconds: 500),
              child: Container(
                padding: EdgeInsets.all(Spacing.smMedium),
                decoration: BoxDecoration(
                  color: LemonColor.atomicBlack,
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.event.eventDashboard.insights.ageGroup,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(
                      height: Spacing.smMedium,
                    ),
                    if (allItems.isEmpty && !isLoading)
                      const EmptyList(size: EmptyListSize.small),
                    if (isLoading)
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...[1, 2, 3].map(
                              (item) => DemographicsPlaceholder(
                                isLast: item == 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (allItems.isNotEmpty)
                      Expanded(
                        child: Row(
                          children: [
                            ...allItemEntries.map((entry) {
                              return _UserByAgeItem(
                                ageGroup: entry.value.users.ageGroup ?? '',
                                ratio: (entry.value.eventsAccepted.count ?? 0) /
                                    totalAccepted,
                              );
                            }),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _UserByAgeItem extends StatelessWidget {
  final String ageGroup;
  final double ratio;

  const _UserByAgeItem({
    required this.ageGroup,
    required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(right: Spacing.xSmall),
      child: Column(
        children: [
          _VerticalProgressBar(ratio: ratio),
          SizedBox(height: Spacing.xSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${(ratio * 100).toInt()}%',
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                ageGroup,
                style: Typo.xSmall.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VerticalProgressBar extends StatelessWidget {
  final _barHeight = 84.w;
  final double ratio;
  _VerticalProgressBar({
    required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(LemonRadius.button),
      child: Container(
        width: Sizing.large,
        height: _barHeight,
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: Sizing.large,
                height: ratio * _barHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(LemonRadius.button),
                    bottomRight: Radius.circular(LemonRadius.button),
                  ),
                  color: ratio >= 0.5
                      ? LemonColor.paleViolet
                      : colorScheme.outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
