import 'package:app/core/presentation/widgets/event/event_dashboard_item.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailDashboard extends StatelessWidget {
  const GuestEventDetailDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EventDashboardItem(
          title: t.event.dashboard.liveChat,
          icon: Assets.icons.icChatBubbleGradient.svg(),
          child: const SizedBox.shrink(),
          onTap: () => AutoRouter.of(context).navigate(const ChatListRoute()),
        ),
        SizedBox(width: 10.w),
        EventDashboardItem(
            title: t.event.dashboard.invite,
            icon: Assets.icons.icUserAddGradient.svg(),
            child: const SizedBox.shrink(),
            onTap: () {
              // TODO: upcoming feature
            }),
        SizedBox(width: 10.w),
        EventDashboardItem(
            title: t.event.dashboard.leaderBoard,
            icon: Assets.icons.icLeaderboardGradient.svg(),
            child: const SizedBox.shrink(),
            onTap: () {
              // TODO: upcoming feature
            }),
      ],
    );
  }
}
