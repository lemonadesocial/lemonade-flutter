import 'package:app/core/domain/event/entities/event_guest_detail/event_guest_detail.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:app/app_theme/app_theme.dart';

class EventGuestDetailTicketWidget extends StatelessWidget {
  final EventGuestDetail? eventGuestDetail;
  final List<EventTicket>? eventTickets;
  final List<EventTicketType>? eventTicketTypes;

  const EventGuestDetailTicketWidget({
    super.key,
    this.eventGuestDetail,
    this.eventTickets,
    this.eventTicketTypes,
  });

  @override
  Widget build(BuildContext context) {
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);

    final tickets = eventTickets ??
        [if (eventGuestDetail?.ticket != null) eventGuestDetail!.ticket!];

    if (tickets.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          t.event.eventGuestDetail.tickets,
          style: appText.md,
        ),
        SizedBox(height: Spacing.small),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tickets.length,
          separatorBuilder: (_, __) => SizedBox(height: Spacing.xSmall),
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            // Find matching ticket type
            final ticketType = eventTicketTypes?.firstWhereOrNull(
                  (type) => type.id == ticket.type,
                ) ??
                ticket.typeExpanded;

            if (ticketType == null) return const SizedBox.shrink();

            return _TicketItem(
              ticket: ticket,
              ticketType: ticketType,
              assignedToInfo: ticket.assignedToInfo,
            );
          },
        ),
      ],
    );
  }
}

class _TicketItem extends StatefulWidget {
  final EventTicket ticket;
  final EventTicketType ticketType;
  final User? assignedToInfo;

  const _TicketItem({
    required this.ticket,
    required this.ticketType,
    this.assignedToInfo,
  });

  @override
  State<_TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<_TicketItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final ticket = widget.ticket;
    final assignedToInfo = widget.assignedToInfo;
    return Container(
      decoration: BoxDecoration(
        color: appColors.cardBg,
        borderRadius: BorderRadius.circular(LemonRadius.small),
        border: Border.all(color: appColors.pageDivider),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Padding(
              padding: EdgeInsets.all(Spacing.small),
              child: Row(
                children: [
                  ThemeSvgIcon(
                    color: appColors.textTertiary,
                    builder: (filter) => Assets.icons.icTicket.svg(
                      width: Sizing.mSmall,
                      height: Sizing.mSmall,
                      colorFilter: filter,
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.ticketType.title ?? '',
                          style: appText.md,
                        ),
                      ],
                    ),
                  ),
                  ThemeSvgIcon(
                    color: appColors.textTertiary,
                    builder: (filter) => isExpanded
                        ? Assets.icons.icArrowUp.svg(
                            width: Sizing.mSmall,
                            height: Sizing.mSmall,
                            colorFilter: filter,
                          )
                        : Assets.icons.icArrowDown.svg(
                            width: Sizing.mSmall,
                            height: Sizing.mSmall,
                            colorFilter: filter,
                          ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            _ExpandedTicketItem(
              ticket: ticket,
              ticketType: widget.ticketType,
              assignedToInfo: assignedToInfo,
            ),
        ],
      ),
    );
  }
}

class _ExpandedTicketItem extends StatelessWidget {
  final EventTicket ticket;
  final EventTicketType ticketType;
  final User? assignedToInfo;

  const _ExpandedTicketItem({
    required this.ticket,
    required this.ticketType,
    this.assignedToInfo,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);

    final String titleText;
    final String displayText;

    if (ticket.assignedEmail?.isNotEmpty == true) {
      titleText = '';
      displayText = ticket.assignedEmail!;
    } else if (assignedToInfo != null) {
      titleText = assignedToInfo?.name ?? '';
      displayText = assignedToInfo?.email ?? '';
    } else {
      titleText = t.event.eventTicketManagement.ticketUnassigned;
      displayText = t.event.eventTicketManagement.assignTicketForGuest;
    }

    return Column(
      children: [
        Divider(height: 1, color: appColors.pageDivider),
        Padding(
          padding: EdgeInsets.all(Spacing.small),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (assignedToInfo != null)
                LemonNetworkImage(
                  imageUrl: assignedToInfo?.imageAvatar ?? '',
                  width: Sizing.small,
                  height: Sizing.small,
                  borderRadius: BorderRadius.circular(Sizing.small),
                  placeholder: ImagePlaceholder.avatarPlaceholder(),
                )
              else
                ThemeSvgIcon(
                  color: appColors.textTertiary,
                  builder: (filter) => Assets.icons.icTicket.svg(
                    width: Sizing.mSmall,
                    height: Sizing.mSmall,
                    colorFilter: filter,
                  ),
                ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (titleText.isNotEmpty)
                      Text(
                        titleText,
                        style: appText.sm,
                      ),
                    if (displayText.isNotEmpty) ...[
                      SizedBox(height: Spacing.superExtraSmall / 2),
                      Text(
                        displayText,
                        style: appText.sm.copyWith(
                          color: appColors.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
