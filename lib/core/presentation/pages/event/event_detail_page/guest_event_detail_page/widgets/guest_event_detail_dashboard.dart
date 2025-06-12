import 'package:app/core/application/event_tickets/generate_event_invitation_url_bloc/generate_event_invitation_url_bloc.dart';
import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/event/event_dashboard_item.dart';
import 'package:app/core/utils/share_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:intl/intl.dart';

class GuestEventDetailDashboard extends StatelessWidget {
  const GuestEventDetailDashboard({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // TODO: hide chat
        // EventDashboardItem(
        //   icon: Assets.icons.icChatBubbleGradient
        //       .svg(width: Sizing.small, height: Sizing.small),
        //   onTap: () {
        //     Vibrate.feedback(FeedbackType.light);
        //     if (event.matrixEventRoomId == null ||
        //         event.matrixEventRoomId!.isEmpty) {
        //       return showDialog(
        //         barrierDismissible: false,
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             backgroundColor: colorScheme.secondary,
        //             title: Text(t.common.alert),
        //             content: SingleChildScrollView(
        //               child: ListBody(
        //                 children: <Widget>[
        //                   Text(t.chat.roomNotExistDesc),
        //                 ],
        //               ),
        //             ),
        //             actions: <Widget>[
        //               TextButton(
        //                 child: Text(
        //                   t.common.actions.ok,
        //                   style: Typo.medium.copyWith(color: Colors.white),
        //                 ),
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        //                 },
        //               ),
        //             ],
        //           );
        //         },
        //       );
        //     }
        //     AutoRouter.of(context).navigate(
        //       ChatRoute(roomId: event.matrixEventRoomId ?? ''),
        //     );
        //   },
        // ),
        // SizedBox(width: 10.w),
        EventDashboardItem(
          icon: Assets.icons.icUserAddGradient
              .svg(width: Sizing.small, height: Sizing.small),
          onTap: () {
            Vibrate.feedback(FeedbackType.light);
            AutoRouter.of(context).navigate(EventInviteFormRoute());
          },
        ),
        SizedBox(width: 10.w),
        EventDashboardItem(
          icon: Assets.icons.icMoreTicketsGradient
              .svg(width: Sizing.small, height: Sizing.small),
          onTap: () async {
            Vibrate.feedback(FeedbackType.light);
            await AutoRouter.of(context).push(
              EventBuyTicketsRoute(
                event: event,
                isBuyMore: true,
              ),
            );
            context.read<GetMyTicketsBloc>().add(
                  GetMyTicketsEvent.fetch(),
                );
          },
        ),
        SizedBox(width: 10.w),
        BlocBuilder<GenerateEventInvitationUrlBloc,
            GenerateEventInvitationUrlState>(
          builder: (context, state) {
            final invitationUrl = state.whenOrNull(
              success: (invitationUrl) => invitationUrl,
            );
            return EventDashboardItem(
              loading: invitationUrl == null,
              icon: Assets.icons.icShareGradient
                  .svg(width: Sizing.small, height: Sizing.small),
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                ShareUtils.shareEvent(context, event);
              },
            );
          },
        ),
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
