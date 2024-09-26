import 'package:app/core/application/event_tickets/get_my_tickets_bloc/get_my_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_basic_info/widgets/post_guest_event_detail_add_ticket_to_wallet_button.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/ticket_qr_code_popup.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class GuestEventDetailBasicInfo extends StatelessWidget {
  const GuestEventDetailBasicInfo({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(
          LemonRadius.medium,
        ),
        border: Border.all(
          color: colorScheme.outline,
          width: 0.5.w,
        ),
      ),
      child: Column(
        children: [
          _EventCountDown(
            event: event,
          ),
          Divider(
            height: 1,
            thickness: 0.5,
            color: colorScheme.outline,
          ),
          const _CheckinButton(),
          Divider(
            height: 1,
            thickness: 0.5,
            color: colorScheme.outline,
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final durationToEvent =
        EventUtils.getDurationToEventText(event, durationOnly: true);
    final (formattedDate, formattedTime) =
        EventUtils.getFormattedEventDateAndTime(event);
    return InkWell(
      onTap: () {
        Vibrate.feedback(FeedbackType.light);
        AutoRouter.of(context).navigate(
          MyEventTicketRoute(
            event: event,
          ),
        );
      },
      child: Padding(
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
                    color: colorScheme.outline,
                  ),
                  imageUrl: event.newNewPhotosExpanded?.isNotEmpty == true
                      ? ImageUtils.generateUrl(
                          file: event.newNewPhotosExpanded?.firstOrNull,
                        )
                      : '',
                  placeholder: ImagePlaceholder.defaultPlaceholder(),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: LemonColor.chineseBlack,
                    borderRadius: BorderRadius.circular(Sizing.medium),
                    border: Border.all(
                      color: colorScheme.outline,
                    ),
                  ),
                  width: Sizing.medium,
                  height: Sizing.medium,
                  child: Center(
                    child: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icTicket.svg(
                        colorFilter: filter,
                        width: 15.w,
                        height: 15.w,
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
                  durationToEvent != null
                      ? Text.rich(
                          TextSpan(
                            text: t.event.eventStartIn(
                              time: "",
                            ),
                            children: [
                              TextSpan(
                                text: durationToEvent,
                                style: Typo.medium.copyWith(
                                  color: LemonColor.rajah,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          t.event.eventEnded,
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  SizedBox(height: 2.w),
                  Text(
                    formattedDate,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                      height: 0,
                    ),
                  ),
                  Text(
                    formattedTime,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckinButton extends StatelessWidget {
  const _CheckinButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return InkWell(
      onTap: () {
        Vibrate.feedback(FeedbackType.light);
        showDialog(
          context: context,
          builder: (context) => const TicketQRCodePopup(),
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
              color: colorScheme.onSecondary,
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
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
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

class _AssignTicketsButton extends StatelessWidget {
  final Event event;

  const _AssignTicketsButton({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
              color: colorScheme.onSecondary,
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
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
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
                      style: Typo.medium.copyWith(
                        color: LemonColor.coralReef,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(width: Spacing.extraSmall),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
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
