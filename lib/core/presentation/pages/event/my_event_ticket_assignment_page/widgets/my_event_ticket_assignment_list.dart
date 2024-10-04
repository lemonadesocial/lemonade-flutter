import 'package:app/core/application/event_tickets/assign_multiple_tickets_form_bloc/assign_multiple_tickets_form_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_assignment_page/my_event_ticket_assignment_page.dart';
import 'package:app/core/presentation/pages/event/my_event_ticket_assignment_page/widgets/ticket_assignment_form_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MyEventTicketAssignmentList extends StatelessWidget {
  final List<EventTicket> eventTickets;
  final List<PurchasableTicketType> ticketTypes;
  final Event event;
  final MyEventTicketAssignmentView controller;

  const MyEventTicketAssignmentList({
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
    return BlocBuilder<AssignMultipleTicketsFormBloc,
        AssignMultipleTicketsFormState>(
      builder: (context, state) {
        return SliverPadding(
          padding: EdgeInsets.zero,
          sliver: MultiSliver(
            children: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.event.eventTicketManagement.assignTicketTitle,
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        t.event.eventTicketManagement.assignTicketDescription,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: Spacing.medium),
              ),
              if (eventTickets.isEmpty)
                SliverToBoxAdapter(
                  child: EmptyList(
                    emptyText: t.event.empty.remainingTickets,
                  ),
                ),
              if (eventTickets.isNotEmpty)
                SliverList.separated(
                  itemBuilder: (context, index) {
                    final ticketAssignee = state.assignees[index];
                    final eventTicket = eventTickets[index];
                    final ticketType = EventTicketUtils.getTicketTypeById(
                      ticketTypes,
                      ticketTypeId: eventTicket.type ?? '',
                    );
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                      child: TicketAssignmentFormItem(
                        eventTicket: eventTicket,
                        ticketType: ticketType,
                        onChangeEmail: (value) {
                          context.read<AssignMultipleTicketsFormBloc>().add(
                                AssignMultipleTicketsFormEvent.updateItem(
                                  index: index,
                                  assignee: ticketAssignee.copyWith(
                                    email: value,
                                  ),
                                ),
                              );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: Spacing.medium),
                    child: Divider(
                      height: 1.w,
                      color: colorScheme.outline,
                    ),
                  ),
                  itemCount: state.assignees.length,
                ),
            ],
          ),
        );
      },
    );
  }
}
