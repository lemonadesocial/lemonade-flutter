import 'package:app/core/application/event_tickets/buy_tickets_with_crypto_bloc/buy_tickets_with_crypto_bloc.dart';
import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyTicketsWithCryptoListener {
  static BlocListener create() {
    return BlocListener<BuyTicketsWithCryptoBloc, BuyTicketsWithCryptoState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          failure: (data, failureReason) {
            if (failureReason is InitCryptoPaymentFailure) {
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

            if (failureReason is UpdateCryptoPaymentFailure) {
              //TODO: payment cannot be updated in BE side
              // still thinking way to backup this case
              showDialog(
                context: context,
                builder: (context) => LemonAlertDialog(
                  onClose: () => Navigator.of(context).pop(),
                  child: Text(t.common.pleaseTryAgain),
                ),
              );
            }

            if (data.selectedNetwork == null) {
              context.read<BuyTicketsWithCryptoBloc>().add(
                    BuyTicketsWithCryptoEvent.resume(
                      state: BuyTicketsWithCryptoState.idle(data: state.data),
                    ),
                  );
            }
            context.read<BuyTicketsWithCryptoBloc>().add(
                  BuyTicketsWithCryptoEvent.resume(
                    state: BuyTicketsWithCryptoState.networkSelected(
                      data: state.data,
                    ),
                  ),
                );
          },
          done: (data) {
            // TODO: will trigger timeout 30s and if payment noti not coming yet => manually
            // call getPayment to check
            // When done, still need to wait for payment success or failed notification below
          },
        );
      },
    );
  }
}
