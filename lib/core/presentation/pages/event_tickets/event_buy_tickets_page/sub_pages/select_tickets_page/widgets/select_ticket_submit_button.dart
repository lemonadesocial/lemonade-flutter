import 'package:app/core/application/event/accept_event_bloc/accept_event_bloc.dart';
import 'package:app/core/application/event_tickets/assign_tickets_bloc/assign_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/redeem_tickets_bloc/redeem_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectTicketSubmitButton extends StatelessWidget {
  final SelectTicketsPaymentMethod paymentMethod;
  final Currency? selectedCurrency;
  final Either<double, BigInt>? totalAmount;

  const SelectTicketSubmitButton({
    super.key,
    required this.paymentMethod,
    required this.totalAmount,
    required this.selectedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final redeemState = context.watch<RedeemTicketsBloc>().state;
    final acceptEventState = context.watch<AcceptEventBloc>().state;
    final assignTicketsState = context.watch<AssignTicketsBloc>().state;
    final isLoading = redeemState is RedeemTicketsStateLoading ||
        acceptEventState is AcceptEventStateLoading ||
        assignTicketsState is AssignTicketsStateLoading;
    String amountText = '';

    if (totalAmount != null) {
      amountText = totalAmount!.fold((fiatAmount) {
        if (fiatAmount == 0) return '';
        return NumberUtils.formatCurrency(
          amount: fiatAmount,
          currency: selectedCurrency,
        );
      }, (cryptoAmount) {
        return Web3Utils.formatCryptoCurrency(
          cryptoAmount,
          currency: selectedCurrency!,
          //TODO: need to get currency info to get decimals
          decimals: 8,
        );
      });
    }

    return BlocBuilder<SelectEventTicketsBloc, SelectEventTicketsState>(
      builder: (context, state) => Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: Opacity(
          opacity: state.isSelectionValid && !isLoading ? 1 : 0.5,
          child: LinearGradientButton(
            height: Sizing.large,
            onTap: () {
              if (!state.isSelectionValid || isLoading) return;
              if (state.isPaymentRequired) {
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
            textStyle: Typo.medium.copyWith(
              fontFamily: FontFamily.nohemiVariable,
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary.withOpacity(0.87),
            ),
            radius: BorderRadius.circular(LemonRadius.small * 2),
            label: isLoading
                ? t.common.processing
                : paymentMethod == SelectTicketsPaymentMethod.card
                    ? '${t.event.eventBuyTickets.payViaCard}  $amountText'
                        .trim()
                    : '${t.event.eventBuyTickets.payViaWallet}  $amountText'
                        .trim(),
            mode: GradientButtonMode.lavenderMode,
          ),
        ),
      ),
    );
  }
}
