import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class GuestEventDetailDashboard extends StatelessWidget {
  const GuestEventDetailDashboard({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: LinearGradientButton(
            onTap: () {
              if (event.matrixEventRoomId == null ||
                  event.matrixEventRoomId!.isEmpty) return;
              AutoRouter.of(context).navigate(
                ChatRoute(roomId: event.matrixEventRoomId ?? ''),
              );
            },
            height: 42.w,
            leading: Assets.icons.icChatBubbleGradient.svg(
              width: Sizing.medium / 2,
              height: Sizing.medium / 2,
            ),
            label: t.event.dashboard.liveChat,
            textStyle: Typo.medium.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(width: Spacing.extraSmall),
        Expanded(
          child: LinearGradientButton(
            onTap: () {
              Share.share(
                '${AppConfig.webUrl}/event/${event.id}',
              );
            },
            height: 42.w,
            leading: Assets.icons.icShareGradient.svg(
              width: Sizing.medium / 2,
              height: Sizing.medium / 2,
            ),
            label: t.common.actions.share,
            textStyle: Typo.medium.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        // TODO: Maybe will reuse
        // EventDashboardItem(
        //   title: t.event.dashboard.liveChat,
        //   icon: Assets.icons.icChatBubbleGradient.svg(),
        //   child: const SizedBox.shrink(),
        //   onTap: () {
        //     if (event.matrixEventRoomId == null ||
        //         event.matrixEventRoomId!.isEmpty) return;
        //     AutoRouter.of(context).navigate(
        //       ChatRoute(roomId: event.matrixEventRoomId ?? ''),
        //     );
        //   },
        // ),
        // SizedBox(width: 10.w),
        // EventDashboardItem(
        //   title: t.event.dashboard.invite,
        //   icon: Assets.icons.icUserAddGradient.svg(),
        //   child: EventTotalJoinWidget(event: event),
        //   onTap: () {
        //     showComingSoonDialog(context);
        //   },
        // ),
        // SizedBox(width: 10.w),
        // EventDashboardItem(
        //   title: t.event.dashboard.leaderBoard,
        //   icon: Assets.icons.icLeaderboardGradient.svg(),
        //   child: const SizedBox.shrink(),
        //   onTap: () {
        //     showComingSoonDialog(context);
        //   },
        // ),
      ],
    );
  }
}

class EventTotalJoinWidget extends StatelessWidget {
  const EventTotalJoinWidget({
    super.key,
    required this.event,
  });

  final Event event;

  int get totalJoined => (event.accepted ?? []).length;

  int get total => totalJoined + (event.pending ?? []).length;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: Spacing.superExtraSmall),
        SizedBox(
          height: 2.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: total != 0 ? totalJoined / total : 0,
              color: const Color(0xFF68F28F),
              backgroundColor: colorScheme.surface,
            ),
          ),
        ),
        SizedBox(height: Spacing.superExtraSmall),
        Text(
          '${NumberFormat.compact().format(totalJoined)}/${NumberFormat.compact().format(total)} ${t.event.confirmed}',
          style: Typo.xSmall.copyWith(
            fontSize: 9.sp,
            color: colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
