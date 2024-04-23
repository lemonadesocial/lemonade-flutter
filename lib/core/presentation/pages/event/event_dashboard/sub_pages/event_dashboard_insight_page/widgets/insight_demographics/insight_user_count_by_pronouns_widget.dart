import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_demographics/demographics_placeholder.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/graphql/cubejs/query/get_user_count_by_dimensions.graphql.dart';
import 'package:app/graphql/cubejs/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Color? getColorByPronoun(String pronoun) {
  if (RegExp('^she', caseSensitive: false).hasMatch(pronoun)) {
    return LemonColor.femaleActiveColor;
  }
  if (RegExp('^he', caseSensitive: false).hasMatch(pronoun)) {
    return LemonColor.maleActiveColor;
  }
  return null;
}

class PronounRatio {
  final double ratio;
  final String pronoun;
  PronounRatio({
    required this.ratio,
    required this.pronoun,
  });
}

class InsightUserCountByPronounWidget extends StatelessWidget {
  final String eventId;
  const InsightUserCountByPronounWidget({
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
        return Query$GetEventAcceptedByPronouns$Widget(
          options: Options$Query$GetEventAcceptedByPronouns(
            variables: Variables$Query$GetEventAcceptedByPronouns(
              limit: 3,
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
                width: 200.w,
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
                      t.event.eventDashboard.insights.pronouns,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(
                      height: Spacing.smMedium,
                    ),
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
                    if (allItems.isEmpty && !isLoading)
                      const EmptyList(size: EmptyListSize.small),
                    if (allItems.isNotEmpty) ...[
                      PronounsRatioMeter(
                        ratios: allItems
                            .map(
                              (item) => PronounRatio(
                                ratio: (item.eventsAccepted.count ?? 0) /
                                    totalAccepted,
                                pronoun: item.users.pronoun ??
                                    t.event.eventDashboard.insights.others,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: Spacing.smMedium,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...allItemEntries.map((entry) {
                              return _UserByPronounItem(
                                pronoun: entry.value.users.pronoun ??
                                    t.event.eventDashboard.insights.others,
                                ratio: (entry.value.eventsAccepted.count ?? 0) /
                                    totalAccepted,
                                isLast: entry.key == allItems.length - 1,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
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

class PronounsRatioMeter extends StatelessWidget {
  final List<PronounRatio> ratios;
  const PronounsRatioMeter({
    super.key,
    required this.ratios,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 42.w,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final widthForGaps = (ratios.length - 1) * Spacing.superExtraSmall;
          final widthForMeter = maxWidth - widthForGaps;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ratios.asMap().entries.map((entry) {
              final isFirst = entry.key == 0;
              final isLast = entry.key == ratios.length - 1;
              return Container(
                decoration: BoxDecoration(
                  color: getColorByPronoun(entry.value.pronoun) ??
                      colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      isFirst ? LemonRadius.xSmall : LemonRadius.xSmall / 3,
                    ),
                    bottomLeft: Radius.circular(
                      isFirst ? LemonRadius.xSmall : LemonRadius.xSmall / 3,
                    ),
                    topRight: Radius.circular(
                      isLast ? LemonRadius.xSmall : LemonRadius.xSmall / 3,
                    ),
                    bottomRight: Radius.circular(
                      isLast ? LemonRadius.xSmall : LemonRadius.xSmall / 3,
                    ),
                  ),
                ),
                height: 42.w,
                width: entry.value.ratio * widthForMeter,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _UserByPronounItem extends StatelessWidget {
  final bool isLast;
  final String pronoun;
  final double ratio;

  const _UserByPronounItem({
    this.isLast = false,
    required this.pronoun,
    required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : Spacing.extraSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            pronoun,
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          Expanded(
            child: DottedLine(
              dashLength: 5.w,
              dashColor: colorScheme.secondaryContainer,
              dashRadius: 2.w,
              lineThickness: 2.w,
            ),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          Text(
            '${(ratio * 100).toInt()}%',
            style: Typo.small.copyWith(
              color: getColorByPronoun(pronoun) ?? colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
