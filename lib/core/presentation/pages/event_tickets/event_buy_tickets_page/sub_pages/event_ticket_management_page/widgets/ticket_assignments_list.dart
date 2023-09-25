import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_list_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_ticket_management_page/event_ticket_management_page.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_ticket_management_page/widgets/ticket_assignment_item.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class TicketAssignmentList extends StatelessWidget {
  final List<EventTicket> eventTickets;
  final List<PurchasableTicketType> ticketTypes;
  final Event event;
  final EventTicketManagementView controller;

  const TicketAssignmentList({
    super.key,
    required this.eventTickets,
    required this.ticketTypes,
    required this.event,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      sliver: MultiSliver(
        children: [
          SliverAppBar(
            collapsedHeight: 105.w,
            pinned: true,
            flexibleSpace: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      t.event.eventTicketManagement.assignTicketTitle,
                      style: Typo.extraLarge.copyWith(
                        color: colorScheme.onPrimary,
                        fontFamily: FontFamily.nohemiVariable,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: Spacing.xSmall),
                    Container(
                      width: 27.w,
                      height: 27.w,
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary.withOpacity(0.09),
                        borderRadius:
                            BorderRadius.circular(LemonRadius.extraSmall),
                      ),
                      child: Center(
                        child: Text(
                          '${eventTickets.length}',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  t.event.eventTicketManagement.assignTicketDescription,
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: Spacing.medium),
              ],
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) {
              final eventTicket = eventTickets[index];
              final ticketType = EventTicketUtils.getTicketTypeById(
                ticketTypes,
                ticketTypeId: eventTicket.type ?? '',
              );
              return TicketAssignmentItem(
                eventTicket: eventTicket,
                ticketType: ticketType,
                currency: event.currency,
                onPressedAssign: () => controller.showAssignPopup(
                  context,
                  eventTicket: eventTicket,
                  ticketType: ticketType,
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: Spacing.xSmall,
            ),
            itemCount: eventTickets.length,
          ),
        ],
      ),
    );
  }
}
