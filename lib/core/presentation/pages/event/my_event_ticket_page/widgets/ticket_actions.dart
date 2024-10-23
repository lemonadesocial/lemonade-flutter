import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/ticket_qr_code_popup.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/event/mutation/email_event_ticket.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTicketActions extends StatelessWidget {
  final Event event;
  final EventTicket? assignedToMeTicket;
  final List<EventTicket>? remainingTickets;

  const EventTicketActions({
    super.key,
    required this.event,
    this.remainingTickets,
    this.assignedToMeTicket,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final currentUser = AuthUtils.getUser(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionItem(
          onPressed: () {
            AutoRouter.of(context)
                .navigate(MyEventTicketAssignmentRoute(event: event));
          },
          label: t.common.actions.assign,
          backgroundColor: LemonColor.lavender18,
          icon: ThemeSvgIcon(
            color: LemonColor.lavender,
            builder: (filter) => Assets.icons.icTicket.svg(
              colorFilter: filter,
              width: 27.w,
              height: 27.w,
            ),
          ),
          badgeIcon: remainingTickets?.isNotEmpty == true
              ? Container(
                  width: Sizing.small,
                  height: Sizing.xSmall,
                  decoration: BoxDecoration(
                    color: LemonColor.lavender,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Center(
                    child: Text(
                      remainingTickets!.length.toString(),
                      style: Typo.small.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              : null,
        ),
        ActionItem(
          label: t.common.actions.invite,
          backgroundColor: LemonColor.inviteBgColor,
          icon: ThemeSvgIcon(
            color: LemonColor.inviteIcColor,
            // color: Colors.red,
            builder: (filter) => Assets.icons.icInvite.svg(
              colorFilter: filter,
              width: 27.w,
              height: 27.w,
            ),
          ),
          onPressed: () => SnackBarUtils.showComingSoon(),
        ),
        ActionItem(
          label: t.common.actions.qrCode,
          backgroundColor: LemonColor.chineseBlack,
          icon: ThemeSvgIcon(
            builder: (filter) => Assets.icons.icQr.svg(
              colorFilter: filter,
              width: 27.w,
              height: 27.w,
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => TicketQRCodePopup(
                data: assignedToMeTicket?.shortId ?? '',
              ),
            );
          },
        ),
        ActionItem(
          label: t.common.actions.receipt,
          backgroundColor: LemonColor.downloadBgColor,
          icon: ThemeSvgIcon(
            color: LemonColor.downloadIcColor,
            // color: Colors.red,
            builder: (filter) => Assets.icons.icReceipt.svg(
              colorFilter: filter,
              width: 27.w,
              height: 27.w,
            ),
          ),
          onPressed: () async {
            final result = await showFutureLoadingDialog(
              context: context,
              future: () => getIt<PaymentRepository>().mailTicketPaymentReciept(
                ticketId: assignedToMeTicket?.id ?? '',
              ),
            );
            result.result?.fold((l) => null, (success) {
              if (!success) {
                SnackBarUtils.showError(
                  message: t.event.eventMail.receiptNotAvailableError,
                );
                return;
              }
              SnackBarUtils.showCustom(
                showIconContainer: false,
                icon: Container(
                  width: Sizing.medium,
                  height: Sizing.medium,
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(Sizing.medium),
                  ),
                  child: Center(
                    child: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (colorFilter) => Assets.icons.icReceipt.svg(
                        colorFilter: colorFilter,
                      ),
                    ),
                  ),
                ),
                title: t.event.eventMail.receiptSentTitle,
                message: t.event.eventMail
                    .checkYourInbox(email: currentUser?.email ?? ''),
              );
            });
          },
        ),
        ActionItem(
          label: t.common.actions.mail,
          backgroundColor: LemonColor.mailBgColor,
          icon: ThemeSvgIcon(
            color: LemonColor.mailIcColor,
            builder: (filter) => Assets.icons.icMail.svg(
              colorFilter: filter,
              width: 27.w,
              height: 27.w,
            ),
          ),
          onPressed: () async {
            final result = await showFutureLoadingDialog(
              context: context,
              future: () => getIt<EventTicketRepository>().mailEventTicket(
                input: Variables$Mutation$MailEventTicket(
                  event: event.id ?? '',
                  emails: [
                    currentUser?.email ?? '',
                  ],
                ),
              ),
            );

            result.result?.fold((l) => null, (success) {
              if (!success) {
                return;
              }
              SnackBarUtils.showCustom(
                showIconContainer: false,
                icon: Container(
                  width: Sizing.medium,
                  height: Sizing.medium,
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(Sizing.medium),
                  ),
                  child: Center(
                    child: ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (colorFilter) => Assets.icons.icTicket.svg(
                        colorFilter: colorFilter,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                  ),
                ),
                title: t.event.eventMail.rsvpSentTitle,
                message: t.event.eventMail
                    .checkYourInbox(email: currentUser?.email ?? ''),
              );
            });
          },
        ),
      ],
    );
  }
}

class ActionItem extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? icon;
  final Widget? badgeIcon;
  final String? label;
  final Function()? onPressed;

  const ActionItem({
    super.key,
    this.icon,
    this.badgeIcon,
    this.backgroundColor,
    this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 54.w,
            height: 54.w,
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline),
              color: backgroundColor,
              borderRadius: BorderRadius.circular(54.w),
            ),
            child: Stack(
              children: [
                Align(
                  child: icon,
                ),
                if (badgeIcon != null)
                  Positioned(
                    top: 2.w,
                    right: 2.w,
                    child: badgeIcon!,
                  ),
              ],
            ),
          ),
          SizedBox(height: Spacing.superExtraSmall),
          Text(
            label ?? '',
            style: Typo.small.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
