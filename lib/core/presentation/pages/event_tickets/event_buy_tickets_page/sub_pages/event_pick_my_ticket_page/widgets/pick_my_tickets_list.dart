import 'package:app/core/application/event_tickets/select_self_assign_ticket_bloc/select_self_assign_ticket_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_pick_my_ticket_page/widgets/pick_ticket_item.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class PickMyTicketsList extends StatelessWidget {
  const PickMyTicketsList({
    super.key,
    required this.ticketTypes,
    required this.event,
    required this.ticketGroupsMap,
  });

  final List<PurchasableTicketType> ticketTypes;
  final Event event;
  final Map<String, List<EventTicket>> ticketGroupsMap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectSelfAssignTicketBloc, SelectSelfAssignTicketState>(
      builder: (context, state) => Flexible(
        flex: 1,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final group = ticketGroupsMap.entries.toList()[index];
                  final ticketTypeId = group.key;
                  final total = group.value.length.toDouble();
                  final ticketType = ticketTypes.firstWhereOrNull(
                    (mTicketType) => mTicketType.id == ticketTypeId,
                  );

                  return PickTicketItem(
                    ticketType: ticketType,
                    total: total,
                    currency: event.currency,
                    selected: state.selectedTicketType == ticketTypeId,
                    onPressed: () =>
                        context.read<SelectSelfAssignTicketBloc>().add(
                              SelectSelfAssignTicketEvent.select(
                                ticketTypeId: ticketTypeId,
                              ),
                            ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: Spacing.xSmall,
                ),
                itemCount: ticketGroupsMap.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
