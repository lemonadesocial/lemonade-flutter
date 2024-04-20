import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_demographics/insight_user_count_by_age_widget.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_demographics/insight_user_count_by_cities_widget.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_demographics/insight_user_count_by_coutries_widget.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_demographics/insight_user_count_by_pronouns_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InsightDemographicsWidget extends StatelessWidget {
  final String eventId;
  const InsightDemographicsWidget({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final charts = [
      InsightUserCountByCountries(eventId: eventId),
      InsightUserCountByCities(eventId: eventId),
      InsightUserCountByAgeWidget(eventId: eventId),
      InsightUserCountByPronounWidget(eventId: eventId),
    ];
    return Container(
      constraints: BoxConstraints(maxHeight: 200.w),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
        scrollDirection: Axis.horizontal,
        itemCount: charts.length,
        itemBuilder: (context, index) {
          return charts[index];
        },
        separatorBuilder: (context, index) => SizedBox(width: Spacing.xSmall),
      ),
    );
  }
}
