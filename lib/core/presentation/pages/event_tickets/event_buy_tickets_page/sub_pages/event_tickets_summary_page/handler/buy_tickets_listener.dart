import 'package:app/core/application/event_tickets/buy_tickets_bloc/buy_tickets_bloc.dart';
import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyTicketsListener {
  static create({
    Function()? onFailure,
  }) {
    return BlocListener<BuyTicketsBloc, BuyTicketsState>(
      listener: (context, state) {
        final t = Translations.of(context);
        state.maybeWhen(
          orElse: () => null,
          failure: (failureReason) {
            if (failureReason is InitPaymentFailure) {
              // cannot init payment, ask user to slide again
              showDialog(
                context: context,
                builder: (context) => LemonAlertDialog(
                  onClose: () => Navigator.of(context).pop(),
                  child: Text(t.common.pleaseTryAgain),
                ),
              );
            }

            if (failureReason is StripePaymentFailure) {
              showDialog(
                context: context,
                builder: (context) => LemonAlertDialog(
                  child: Text(
                    failureReason.exception.error.message ??
                        t.common.pleaseTryAgain,
                  ),
                ),
              );
            }

            if (failureReason is UpdatePaymentFailure) {
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
            // reset slide button
            onFailure?.call();
          },
          done: (payment) {
            // TODO: will trigger timeout 30s and if payment noti not coming yet => manually
            // call getPayment to check
            // When done, still need to wait for payment success or failed notification below
          },
        );
      },
    );
  }
}
