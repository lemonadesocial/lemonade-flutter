import 'package:app/core/application/event/accept_event_bloc/accept_event_bloc.dart';
import 'package:app/core/application/event_tickets/assign_tickets_bloc/assign_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/redeem_tickets_bloc/redeem_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/event/input/redeem_tickets_input/redeem_tickets_input.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectTicketSubmitButton extends StatelessWidget {
  const SelectTicketSubmitButton({
    required this.event,
    required this.listTicket,
    super.key,
  });

  final Event event;
  final List<PurchasableTicketType> listTicket;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final redeemState = context.watch<RedeemTicketsBloc>().state;
    final acceptEventState = context.watch<AcceptEventBloc>().state;
    final assignTicketsState = context.watch<AssignTicketsBloc>().state;
    final isLoading = redeemState is RedeemTicketsStateLoading ||
        acceptEventState is AcceptEventStateLoading ||
        assignTicketsState is AssignTicketsStateLoading;

    /// Calculate total ticket price locally, if total > 0
    /// we moving it to payment flow
    final totalPrice = listTicket.map((e) => (e.price ?? 0) * e.count).sum;
    final totalTicket = listTicket.map((e) => e.count).sum;
    final freeTicketList = listTicket
      ..removeWhere((ticket) => ticket.price == 0);
    final redeemItemList = freeTicketList
        .map(
          (ticketType) => RedeemItem(
            count: ticketType.count,
            ticketType: ticketType.id ?? '',
          ),
        )
        .toList();
    final buttonLabel =
        totalPrice == 0 ? t.common.next : '${t.common.next} . $totalPrice';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
      child: SizedBox(
        height: Sizing.large,
        child: LinearGradientButton(
          onTap: totalTicket > 0
              ? () {
                  totalPrice > 0
                      ? context.router.push(
                          EventTicketsSummaryRoute(
                            event: event,
                            listTicket: listTicket,
                          ),
                        )
                      : context.read<RedeemTicketsBloc>().add(
                            RedeemTicketsEvent.redeem(
                              ticketItems: redeemItemList,
                            ),
                          );
                }
              : null,
          radius: BorderRadius.circular(LemonRadius.small * 2),
          label: isLoading ? t.common.processing : buttonLabel,
          mode: totalTicket > 0
              ? GradientButtonMode.lavenderMode
              : GradientButtonMode.lavenderDisableMode,
          loadingWhen: isLoading,
        ),
      ),
    );
  }
}
