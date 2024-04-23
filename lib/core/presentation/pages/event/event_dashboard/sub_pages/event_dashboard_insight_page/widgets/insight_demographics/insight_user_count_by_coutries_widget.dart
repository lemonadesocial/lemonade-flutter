import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_demographics/demographics_placeholder.dart';
import 'package:app/graphql/cubejs/query/get_event_track_views.graphql.dart';
import 'package:app/graphql/cubejs/query/get_user_count_by_dimensions.graphql.dart';
import 'package:app/graphql/cubejs/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InsightUserCountByCountries extends StatelessWidget {
  final String eventId;
  const InsightUserCountByCountries({
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
      builder: (trackViewsResult, {refetch, fetchMore}) =>
          Query$GetEventCountDistinctUserByCountry$Widget(
        options: Options$Query$GetEventCountDistinctUserByCountry(
          variables: Variables$Query$GetEventCountDistinctUserByCountry(
            limit: 3,
            where: Input$TracksWhereInput(
              metaEventId: Input$StringFilter(equals: eventId),
              countDistinctUsers: Input$FloatFilter(gt: 0),
            ),
          ),
          fetchPolicy: FetchPolicy.noCache,
        ),
        builder: (result, {refetch, fetchMore}) {
          final totalUserViews = trackViewsResult.parsedData?.cube.firstOrNull
                  ?.trackViews.countDistinctUsers ??
              1;
          final allItems = result.parsedData?.cube.toList() ?? [];
          final isLoading = result.isLoading || trackViewsResult.isLoading;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              borderRadius: BorderRadius.circular(LemonRadius.medium),
            ),
            width: 200.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.event.eventDashboard.insights.topCountries,
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
                            return _UserByCountryItem(
                              ratio: ((entry.value.tracks.countDistinctUsers ??
                                      0) /
                                  totalUserViews),
                              countryCode:
                                  entry.value.tracks.geoipCountry ?? '',
                              count: (entry.value.tracks.countDistinctUsers
                                          ?.toInt() ??
                                      0)
                                  .toString(),
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
      ),
    );
  }
}

class _UserByCountryItem extends StatelessWidget {
  final bool isLast;
  final String countryCode;
  final String count;
  final double ratio;

  const _UserByCountryItem({
    required this.countryCode,
    required this.count,
    required this.ratio,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : Spacing.extraSmall),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            LemonColor.atomicBlack,
            colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      padding: EdgeInsets.only(
        top: Spacing.xSmall,
        bottom: Spacing.xSmall,
        right: Spacing.smMedium,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '${Country.tryParse(countryCode)?.flagEmoji}   ',
                style: Typo.small.copyWith(
                  color: colorScheme.onPrimary,
                ),
                children: [
                  TextSpan(
                    text: Country.tryParse(countryCode)?.name ?? '',
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
              maxLines: 1,
            ),
          ),
          Text(
            '${(ratio * 100).toInt().toString()}%',
            style: Typo.small.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
