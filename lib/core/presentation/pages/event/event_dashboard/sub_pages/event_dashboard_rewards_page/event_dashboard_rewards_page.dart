import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_sampling_chart/insight_sampling_chart.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_rewards_page/widgets/dasboard_rewards_standing.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_rewards_page/widgets/dashboard_rewards_overview.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class EventDashboardRewardsPage extends StatelessWidget {
  final Event event;
  const EventDashboardRewardsPage({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: const SliverToBoxAdapter(
            child: DashboardRewardsOverview(),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.smMedium * 2,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: DashboardRewardsStanding(
            event: event,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.smMedium * 2,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          sliver: SliverToBoxAdapter(
            child: InsightSamplingChart(eventId: event.id ?? ''),
          ),
        ),
      ],
    );
  }
}
