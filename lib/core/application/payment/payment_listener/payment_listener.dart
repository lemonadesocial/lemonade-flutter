import 'dart:convert';

import 'package:app/core/application/notification/watch_notifications_bloc/watch_notification_bloc.dart';
import 'package:app/core/data/notification/notification_constants.dart';
import 'package:app/core/data/payment/dtos/payment_dto/payment_dto.dart';
import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentListener extends StatelessWidget {
  final Widget? child;
  final Function(String eventId, Payment payment)? onReceivedPaymentSuccess;
  final Function(String eventId, Payment payment)? onReceivedPaymentFailed;

  const PaymentListener({
    super.key,
    this.child,
    this.onReceivedPaymentSuccess,
    this.onReceivedPaymentFailed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchNotificationsBloc, WatchNotificationsState>(
      listener: (context, state) {
        state.when(
          idle: () => null,
          hasNewNotification: (notification) {
            if (notification.type != NotificationType.paymentSuccess &&
                notification.type != NotificationType.paymentFailed) {
              return;
            }

            final eventId = notification.refEvent ?? '';
            Map<String, dynamic>? paymentData =
                notification.data?['payment'] != null
                    ? jsonDecode(notification.data?['payment'])
                    : null;
            final payment = paymentData != null
                ? Payment.fromDto(PaymentDto.fromJson(paymentData))
                : null;

            if (payment == null) return;

            if (notification.type == NotificationType.paymentSuccess) {
              onReceivedPaymentSuccess?.call(eventId, payment);
              return;
            }

            if (notification.type == NotificationType.paymentFailed) {
              onReceivedPaymentFailed?.call(eventId, payment);
              return;
            }
          },
        );
      },
      child: child,
    );
  }
}
