import 'package:app/core/application/event_tickets/buy_tickets_bloc/buy_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event_join_request.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyTicketsListener {
  static create({
    Function()? onFailure,
    Function({
      Payment? payment,
      EventJoinRequest? eventJoinRequest,
    })? onDone,
  }) {
    return BlocListener<BuyTicketsBloc, BuyTicketsState>(
      listener: (context, state) {
        final t = Translations.of(context);
        state.maybeWhen(
          orElse: () => null,
          failure: (failureReason) {
            if (failureReason is InitPaymentFailure ||
                failureReason is UpdatePaymentFailure ||
                failureReason is NotificationPaymentFailure) {
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

            // reset slide button
            onFailure?.call();
          },
          done: (payment, eventJoinRequest) {
            onDone?.call(
              payment: payment,
              eventJoinRequest: eventJoinRequest,
            );
          },
        );
      },
    );
  }
}
