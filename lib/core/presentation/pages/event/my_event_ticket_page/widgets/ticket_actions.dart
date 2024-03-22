import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_page/widgets/ticket_qr_code_popup.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
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
  final List<EventTicket>? remainingTickets;

  const EventTicketActions({
    super.key,
    required this.event,
    this.remainingTickets,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActionItem(
          label: t.common.actions.download,
          backgroundColor: LemonColor.downloadBgColor,
          icon: ThemeSvgIcon(
            color: LemonColor.downloadIcColor,
            // color: Colors.red,
            builder: (filter) => Assets.icons.icDownload.svg(
              colorFilter: filter,
              width: 27.w,
              height: 27.w,
            ),
          ),
          onPressed: () => SnackBarUtils.showComingSoon(context: context),
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
          onPressed: () => SnackBarUtils.showComingSoon(context: context),
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
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) => const TicketQRCodePopup(),
            ),
          },
        ),
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
          onPressed: () => SnackBarUtils.showComingSoon(context: context),
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
