import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/buy_tickets_with_crypto_bloc.dart';
import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyTicketsWithCryptoListener {
  static BlocListener create({
    Function(BuyTicketsWithCryptoStateData data)? onDone,
  }) {
    return BlocListener<BuyTicketsWithCryptoBloc, BuyTicketsWithCryptoState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          failure: (data, failureReason) {
            if (failureReason is InitCryptoPaymentFailure ||
                failureReason is UpdateCryptoPaymentFailure ||
                failureReason is NotificationCryptoPaymentFailure) {
              showDialog(
                context: context,
                builder: (context) => LemonAlertDialog(
                  onClose: () => Navigator.of(context).pop(),
                  child: Text(t.common.pleaseTryAgain),
                ),
              );
            }

            if (failureReason is WalletConnectFailure) {
              showDialog(
                context: context,
                builder: (context) => LemonAlertDialog(
                  onClose: () => Navigator.of(context).pop(),
                  child: Text(failureReason.message ?? t.common.pleaseTryAgain),
                ),
              );
            }

            context.read<BuyTicketsWithCryptoBloc>().add(
                  BuyTicketsWithCryptoEvent.resume(
                    state: BuyTicketsWithCryptoState.idle(data: state.data),
                  ),
                );
          },
          done: (data) {
            // TODO: will trigger timeout 30s and if payment noti not coming yet => manually
            // call getPayment to check
            // When done, still need to wait for payment success or failed notification below
            onDone?.call(data);
          },
        );
      },
    );
  }
}
