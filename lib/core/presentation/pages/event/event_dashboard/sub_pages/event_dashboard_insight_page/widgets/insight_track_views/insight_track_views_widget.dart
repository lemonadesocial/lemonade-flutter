import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_track_views/track_view_item_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/cubejs/query/get_event_session_average_duration.graphql.dart';
import 'package:app/graphql/cubejs/query/get_event_tickets_sold.graphql.dart';
import 'package:app/graphql/cubejs/query/get_event_track_views.graphql.dart';
import 'package:app/graphql/cubejs/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InsightTrackViewsWidget extends StatelessWidget {
  final String eventId;
  const InsightTrackViewsWidget({
    super.key,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Query$GetTrackViews$Widget(
          options: Options$Query$GetTrackViews(
            fetchPolicy: FetchPolicy.noCache,
            variables: Variables$Query$GetTrackViews(
              where: Input$TrackViewsWhereInput(
                metaEventId: Input$StringFilter(equals: eventId),
              ),
            ),
          ),
          builder: (result, {refetch, fetchMore}) {
            final cubeData = result.parsedData?.cube.firstOrNull;
            final totalViews = cubeData?.trackViews.count?.toInt() ?? 0;
            final uniqeViews =
                cubeData?.trackViews.countDistinctUsers?.toInt() ?? 0;

            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TrackViewItem(
                    icon: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icVideoClip.svg(
                        colorFilter: filter,
                      ),
                    ),
                    label: t.event.eventDashboard.insights.totalViews,
                    count: totalViews.toString(),
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
                Expanded(
                  child: TrackViewItem(
                    icon: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icStar.svg(
                        colorFilter: filter,
                      ),
                    ),
                    label: t.event.eventDashboard.insights.uniqueViews,
                    count: uniqeViews.toString(),
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: Spacing.xSmall),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Query$GetEventSessionAverageDuration$Widget(
              options: Options$Query$GetEventSessionAverageDuration(
                fetchPolicy: FetchPolicy.noCache,
              ),
              builder: (result, {refetch, fetchMore}) {
                final cubeData = result.parsedData?.cube.firstOrNull;
                final averageMins =
                    cubeData?.sessions.averageDurationMinutes?.toInt() ?? 0;

                return Expanded(
                  child: TrackViewItem(
                    icon: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icLive.svg(
                        width: 18.w,
                        height: 18.w,
                        colorFilter: filter,
                      ),
                    ),
                    label: t.event.eventDashboard.insights.avarageSession,
                    count: averageMins.toString(),
                  ),
                );
              },
            ),
            SizedBox(width: Spacing.xSmall),
            Query$GetTicketsSold$Widget(
              options: Options$Query$GetTicketsSold(
                fetchPolicy: FetchPolicy.noCache,
                variables: Variables$Query$GetTicketsSold(
                  where: Input$TicketsWhereInput(
                    event: Input$StringFilter(equals: eventId),
                  ),
                ),
              ),
              builder: (result, {refetch, fetchMore}) {
                final cubeData = result.parsedData?.cube.firstOrNull;
                final ticketsSold = cubeData?.tickets.count?.toInt() ?? 0;

                return Expanded(
                  child: TrackViewItem(
                    icon: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icTicket.svg(
                        width: 18.w,
                        height: 18.w,
                        colorFilter: filter,
                      ),
                    ),
                    label: t.event.eventDashboard.insights.ticketsSold,
                    count: ticketsSold.toString(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
