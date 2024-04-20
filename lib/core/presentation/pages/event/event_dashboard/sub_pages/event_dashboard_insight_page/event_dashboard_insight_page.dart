import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_demographics/insight_demographics_widget.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_track_views/insight_track_views_widget.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventDashboardInsightPage extends StatelessWidget {
  final Event event;
  const EventDashboardInsightPage({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverToBoxAdapter(
            child: InsightTrackViewsWidget(
              eventId: event.id ?? '',
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.smMedium * 2),
        ),
        SliverToBoxAdapter(
          child: InsightDemographicsWidget(
            eventId: event.id ?? '',
          ),
        ),
      ],
    );
  }
}
