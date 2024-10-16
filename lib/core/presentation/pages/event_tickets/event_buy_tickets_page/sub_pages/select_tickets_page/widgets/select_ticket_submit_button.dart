import 'package:app/core/application/event/accept_event_bloc/accept_event_bloc.dart';
import 'package:app/core/application/event_tickets/assign_tickets_bloc/assign_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/redeem_tickets_bloc/redeem_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectTicketSubmitButton extends StatelessWidget {
  final SelectTicketsPaymentMethod paymentMethod;
  final String? selectedCurrency;
  final String? selectedNetwork;
  final Either<double, BigInt>? totalAmount;
  final Event event;

  const SelectTicketSubmitButton({
    super.key,
    required this.paymentMethod,
    required this.totalAmount,
    required this.selectedCurrency,
    required this.selectedNetwork,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final redeemState = context.watch<RedeemTicketsBloc>().state;
    final acceptEventState = context.watch<AcceptEventBloc>().state;
    final assignTicketsState = context.watch<AssignTicketsBloc>().state;
    final isLoading = redeemState is RedeemTicketsStateLoading ||
        acceptEventState is AcceptEventStateLoading ||
        assignTicketsState is AssignTicketsStateLoading;
    List<EventCurrency> eventCurrencies =
        context.watch<GetEventTicketTypesBloc>().state.maybeWhen(
              orElse: () => [],
              success: (_, currencies) => currencies,
            );
    String amountText = '';
    if (totalAmount != null) {
      amountText = totalAmount!.fold((fiatAmount) {
        if (fiatAmount == 0) return '';
        return NumberUtils.formatCurrency(
          amount: fiatAmount,
          currency: selectedCurrency,
        );
      }, (cryptoAmount) {
        if (selectedCurrency == null) return '';
        final decimals = EventTicketUtils.getEventCurrency(
              currencies: eventCurrencies,
              network: selectedNetwork,
              currency: selectedCurrency,
            )?.decimals ??
            2;
        return Web3Utils.formatCryptoCurrency(
          cryptoAmount,
          currency: selectedCurrency!,
          decimals: decimals.toInt(),
        );
      });
    }

    return BlocBuilder<SelectEventTicketsBloc, SelectEventTicketsState>(
      builder: (context, state) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: Opacity(
          opacity: state.isSelectionValid && !isLoading ? 1 : 0.5,
          child: LinearGradientButton.primaryButton(
            onTap: () {
              if (!state.isSelectionValid || isLoading) return;
              if (state.isPaymentRequired || event.approvalRequired == true) {
                context.router.push(
                  const EventTicketsSummaryRoute(),
                );
              } else {
                context.read<RedeemTicketsBloc>().add(
                      RedeemTicketsEvent.redeem(
                        ticketItems: state.selectedTickets,
                      ),
                    );
              }
            },
            label: isLoading
                ? t.common.processing
                : !state.isPaymentRequired
                    ? t.event.eventBuyTickets.redeem
                    : paymentMethod == SelectTicketsPaymentMethod.card
                        ? '${t.event.eventBuyTickets.payViaCard}  $amountText'
                            .trim()
                        : '${t.event.eventBuyTickets.payViaWallet}  $amountText'
                            .trim(),
          ),
        ),
      ),
    );
  }
}
