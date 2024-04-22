import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/cubejs/entities/cube_reward_use/cube_reward_use.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_track_views/track_view_item_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/cubejs_service/cubejs_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardRewardsOverview extends StatelessWidget {
  const DashboardRewardsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final event = context.read<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        FutureBuilder(
          future: CubeJsService(eventId: event?.id ?? '').query(
            body: {
              "measures": ["EventRewardUses.count"],
            },
          ),
          builder: (context, snapshot) {
            final totalClaims = snapshot.data?.fold((left) => 0, (data) {
              final rewardUse = data.firstOrNull != null
                  ? CubeRewardUse.fromJson(data.firstOrNull)
                  : null;
              return rewardUse?.count ?? 0;
            });
            return Expanded(
              child: TrackViewItem(
                icon: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icDownload.svg(
                    colorFilter: filter,
                    width: 18.w,
                    height: 18.w,
                  ),
                ),
                label: t.event.eventDashboard.reward.totalClaims,
                count: totalClaims?.toStringAsFixed(0) ?? '0',
              ),
            );
          },
        ),
        SizedBox(width: Spacing.xSmall),
        Expanded(
          child: TrackViewItem(
            icon: ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icCrystal.svg(
                colorFilter: filter,
                width: 18.w,
                height: 18.w,
              ),
            ),
            label: t.event.eventDashboard.reward.created,
            count: event?.rewards?.length.toString() ?? '0',
          ),
        ),
      ],
    );
  }
}
