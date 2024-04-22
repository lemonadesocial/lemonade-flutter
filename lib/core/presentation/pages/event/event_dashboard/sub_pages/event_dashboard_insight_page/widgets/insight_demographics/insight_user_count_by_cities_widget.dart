import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_demographics/demographics_placeholder.dart';
import 'package:app/graphql/cubejs/query/get_event_track_views.graphql.dart';
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

class InsightUserCountByCities extends StatelessWidget {
  final String eventId;
  const InsightUserCountByCities({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Query$GetTrackViews$Widget(
      options: Options$Query$GetTrackViews(
        fetchPolicy: FetchPolicy.noCache,
        variables: Variables$Query$GetTrackViews(
          where: Input$TrackViewsWhereInput(
            metaEventId: Input$StringFilter(equals: eventId),
          ),
        ),
      ),
      builder: (trackViewsResult, {fetchMore, refetch}) {
        return Query$GetEventCountDistinctUserByCity$Widget(
          options: Options$Query$GetEventCountDistinctUserByCity(
            variables: Variables$Query$GetEventCountDistinctUserByCity(
              limit: 3,
              where: Input$TracksWhereInput(
                countDistinctUsers: Input$FloatFilter(
                  gt: 0,
                ),
              ),
            ),
            fetchPolicy: FetchPolicy.noCache,
          ),
          builder: (result, {refetch, fetchMore}) {
            final totalUserViews = trackViewsResult.parsedData?.cube.firstOrNull
                    ?.trackViews.countDistinctUsers ??
                1;
            final allItems = result.parsedData?.cube ?? [];
            final isLoading = result.isLoading || trackViewsResult.isLoading;
            return Container(
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
                    t.event.eventDashboard.insights.topCities,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(
                    height: Spacing.smMedium,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (allItems.isEmpty || isLoading)
                          ...[1, 2, 3].map((item) {
                            return DemographicsPlaceholder(
                              isLast: item == 3,
                            );
                          }),
                        if (allItems.isNotEmpty && !isLoading)
                          ...allItems.asMap().entries.map(
                            (entry) {
                              return _UserByCityItem(
                                city: entry.value.tracks.geoipCity ?? '',
                                countryCode:
                                    entry.value.tracks.geoipCountry ?? '',
                                ratio: (entry.value.tracks.countDistinctUsers ??
                                        0) /
                                    totalUserViews,
                                isLast: entry.key == allItems.length - 1,
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _UserByCityItem extends StatelessWidget {
  final String countryCode;
  final String city;
  final double ratio;
  final bool isLast;

  const _UserByCityItem({
    required this.countryCode,
    required this.city,
    required this.ratio,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : Spacing.extraSmall),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _HorizontalProgressBar(ratio: ratio),
          SizedBox(width: Spacing.small),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${(ratio * 100).toInt()}%',
                  style: Typo.small.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$city,$countryCode',
                  style: Typo.xSmall.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HorizontalProgressBar extends StatelessWidget {
  final double ratio;
  const _HorizontalProgressBar({
    required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(LemonRadius.button),
      child: Container(
        width: 70.w,
        height: Sizing.medium,
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
        ),
        child: Stack(
          children: [
            Container(
              width: ratio * 70.w,
              height: Sizing.medium,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(LemonRadius.button),
                  bottomLeft: Radius.circular(LemonRadius.button),
                ),
                color:
                    ratio >= 0.5 ? LemonColor.paleViolet : colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
