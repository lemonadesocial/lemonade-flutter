import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/application/token_reward/get_my_event_token_rewards_bloc/get_my_event_token_rewards_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/reward/entities/reward_signature_response.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_basic_info/widgets/post_guest_event_detail_add_ticket_to_wallet_button.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/ticket_qr_code_popup.dart';
import 'package:app/core/presentation/widgets/common/add_to_calendar_bottomsheet/add_to_calendar_bottomsheet.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:collection/collection.dart';
import 'package:app/app_theme/app_theme.dart';

class GuestEventDetailBasicInfo extends StatelessWidget {
  const GuestEventDetailBasicInfo({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return Container(
      decoration: BoxDecoration(
        color: appColors.cardBg,
        borderRadius: BorderRadius.circular(
          LemonRadius.medium,
        ),
        border: Border.all(
          color: appColors.cardBorder,
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          _EventCountDown(
            event: event,
          ),
          Divider(
            height: 1,
            thickness: 1.w,
            color: appColors.pageDivider,
          ),
          const _CheckinButton(),
          Divider(
            height: 1,
            thickness: 1.w,
            color: appColors.pageDivider,
          ),
          BlocBuilder<GetMyEventTokenRewardsBloc, GetMyEventTokenRewardsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                success: (rewardResponses) {
                  if (rewardResponses.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ClaimTokenRewardButton(
                        event: event,
                        rewardResponses: rewardResponses,
                      ),
                      Divider(
                        height: 1,
                        thickness: 1.w,
                        color: appColors.pageDivider,
                      ),
                    ],
                  );
                },
              );
            },
          ),
          _AssignTicketsButton(event: event),
        ],
      ),
    );
  }
}

class _EventCountDown extends StatelessWidget {
  const _EventCountDown({
    required this.event,
  });

  final Event event;

  void _addToCalendar(BuildContext context) {
    AddToCalendarBottomSheet.show(
      context,
      EventUtils.generateDeviceCalendarEvent(context, event: event),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    final (formattedDate, formattedTime) =
        EventUtils.getFormattedEventDateAndTime(event);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Spacing.small,
        horizontal: Spacing.small,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LemonNetworkImage(
                width: 42.w,
                height: 42.w,
                borderRadius: BorderRadius.circular(
                  LemonRadius.extraSmall,
                ),
                border: Border.all(
                  color: appColors.cardBorder,
                ),
                imageUrl: event.newNewPhotosExpanded?.isNotEmpty == true
                    ? ImageUtils.generateUrl(
                        file: event.newNewPhotosExpanded?.firstOrNull,
                      )
                    : '',
                placeholder: ImagePlaceholder.eventCard(),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  AutoRouter.of(context).navigate(
                    MyEventTicketRoute(
                      event: event,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: appColors.cardBg,
                    borderRadius: BorderRadius.circular(Sizing.medium),
                    border: Border.all(
                      color: appColors.cardBorder,
                    ),
                  ),
                  width: Sizing.medium,
                  height: Sizing.medium,
                  child: Center(
                    child: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icTicket.svg(
                        colorFilter: filter,
                        width: 15.w,
                        height: 15.w,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Spacing.extraSmall),
              InkWell(
                onTap: () {
                  _addToCalendar(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: appColors.cardBg,
                    borderRadius: BorderRadius.circular(Sizing.medium),
                    border: Border.all(
                      color: appColors.cardBorder,
                    ),
                  ),
                  width: Sizing.medium,
                  height: Sizing.medium,
                  child: Center(
                    child: ThemeSvgIcon(
                      color: appColors.textTertiary,
                      builder: (filter) => Assets.icons.icCalendarAddLine.svg(
                        colorFilter: filter,
                        width: 15.w,
                        height: 15.w,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Spacing.extraSmall),
              PostGuestEventDetailAddTicketToWalletButton(event: event),
            ],
          ),
          SizedBox(height: Spacing.small),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEventStatusText(context, event),
                SizedBox(height: 2.w),
                Text(
                  formattedDate,
                  style: appText.sm.copyWith(
                    color: appColors.textSecondary,
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  formattedTime,
                  style: appText.sm.copyWith(
                    color: appColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventStatusText(BuildContext context, Event event) {
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    final now = DateTime.now();
    final durationOnlyText = EventUtils.getDurationToEventText(
      event,
      durationOnly: true,
    );
    final start = event.start ?? now;
    final end = event.end ?? now;

    if (now.isAfter(end)) {
      return Text(
        t.event.eventEnded,
        style: appText.md,
      );
    }

    final statusText = now.isAfter(start)
        ? t.common.started.capitalize()
        : t.event.startingIn.capitalize();

    return Text.rich(
      TextSpan(
        text: '$statusText ',
        style: appText.md,
        children: [
          TextSpan(
            text: '$durationOnlyText ',
            style: appText.md.copyWith(
              color: LemonColor.rajah,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckinButton extends StatelessWidget {
  const _CheckinButton();

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    final userId = AuthUtils.getUserId(context);
    return BlocBuilder<GetMyTicketsBloc, GetMyTicketsState>(
      builder: (context, myTicketsState) {
        return InkWell(
          onTap: () {
            final assignedToMeTicket = myTicketsState.maybeWhen(
              orElse: () => null,
              success: (myTickets) => myTickets.firstWhereOrNull(
                (ticket) => EventTicketUtils.isTicketAssignedToMe(
                  ticket,
                  userId: userId,
                ),
              ),
            );
            Vibrate.feedback(FeedbackType.light);
            showDialog(
              context: context,
              builder: (context) => TicketQRCodePopup(
                data: assignedToMeTicket?.shortId ?? '',
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.small,
              horizontal: Spacing.small,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icCheckin.svg(
                    colorFilter: filter,
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                  ),
                ),
                SizedBox(width: Spacing.small),
                Expanded(
                  child: Text(
                    t.event.configuration.checkIn,
                    style: appText.md,
                  ),
                ),
                ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icArrowRight.svg(
                    colorFilter: filter,
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AssignTicketsButton extends StatelessWidget {
  final Event event;

  const _AssignTicketsButton({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          MyEventTicketAssignmentRoute(
            event: event,
            onAssignSuccess: () {
              context.read<GetMyTicketsBloc>().add(
                    GetMyTicketsEvent.fetch(),
                  );
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.small,
          horizontal: Spacing.small,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icTicket.svg(
                colorFilter: filter,
                width: Sizing.mSmall,
                height: Sizing.mSmall,
              ),
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Text(
                t.event.eventBuyAdditionalTickets.assignTickets,
                style: appText.md,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            BlocBuilder<GetMyTicketsBloc, GetMyTicketsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  success: (tickets) {
                    final remainingTickets = tickets
                        .where(
                          (ticket) =>
                              EventTicketUtils.isTicketNotAssigned(ticket),
                        )
                        .toList();
                    if (remainingTickets.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      remainingTickets.length.toString(),
                      style: appText.md.copyWith(
                        color: appColors.textError,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(width: Spacing.extraSmall),
            ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
                width: Sizing.mSmall,
                height: Sizing.mSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClaimTokenRewardButton extends StatelessWidget {
  const _ClaimTokenRewardButton({
    required this.event,
    required this.rewardResponses,
  });

  final Event event;
  final List<RewardSignatureResponse> rewardResponses;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          EventDetailClaimTokenRewardRoute(
            event: event,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.small,
          horizontal: Spacing.small,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icGift.svg(
                colorFilter: filter,
                width: Sizing.mSmall,
                height: Sizing.mSmall,
              ),
            ),
            SizedBox(width: Spacing.small),
            Expanded(
              child: Text(
                t.event.tokenReward.claimRewards,
                style: appText.md,
              ),
            ),
            Text(
              rewardResponses.length.toString(),
              style: appText.md.copyWith(
                color: appColors.textAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: Spacing.extraSmall),
            ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
                width: Sizing.mSmall,
                height: Sizing.mSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
