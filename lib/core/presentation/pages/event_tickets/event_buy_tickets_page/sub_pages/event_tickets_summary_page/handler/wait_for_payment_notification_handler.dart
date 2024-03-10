import 'dart:async';

import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/input/get_payment_input/get_payment_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';

class WaitForPaymentNotificationHandler {
  Timer? timer;

  static get maxDurationToWaitForNotification => const Duration(minutes: 3);

  static get delayIntervalDuration => const Duration(seconds: 5);

  Future<Payment?> _checkPayment(String paymentId) async {
    int remainingAttempt = 10;
    Payment? payment;
    while (remainingAttempt > 0) {
      Future.delayed(
        delayIntervalDuration,
      );
      final paymentResult = await getIt<PaymentRepository>().getPayment(
        input: GetPaymentInput(
          id: paymentId,
        ),
      );
      payment = paymentResult.fold(
        (l) => null,
        (r) => r,
      );
      if (payment?.state == PaymentState.succeeded) {
        return payment;
      }
      remainingAttempt--;
    }
    return payment;
  }

  start(
    BuildContext context, {
    required String paymentId,
    Function()? onPaymentDone,
    Function()? onPaymentFailed,
  }) async {
    timer = Timer(maxDurationToWaitForNotification, () async {
      final paymentResult = await getIt<PaymentRepository>().getPayment(
        input: GetPaymentInput(
          id: paymentId,
        ),
      );
      final payment = paymentResult.fold(
        (l) => null,
        (r) => r,
      );

      if (payment?.state == PaymentState.succeeded) {
        onPaymentDone?.call();
      } else {
        onPaymentFailed?.call();
      }
    });
  }

  startWithCrypto(
    BuildContext context, {
    required String chainId,
    required String txHash,
    required String paymentId,
    Function()? onPaymentDone,
    Function()? onPaymentFailed,
  }) async {
    timer = Timer(maxDurationToWaitForNotification, () async {
      final getChainResult =
          await getIt<Web3Repository>().getChainById(chainId: chainId);
      final chain = getChainResult.getOrElse(() => null);
      final receipt = await Web3Utils.waitForReceipt(
        rpcUrl: chain?.rpcUrl ?? '',
        txHash: txHash,
        deplayDuration: delayIntervalDuration,
      );
      // This make sure BE already confirmed after transaction receipt is retured
      await Future.delayed(
        Duration(
          seconds: (chain?.blockTime?.toInt() ?? 1) *
              (chain?.safeConfirmations?.toInt() ?? 1),
        ),
      );
      final payment = await _checkPayment(paymentId);

      if (receipt?.status == true && payment?.state == PaymentState.succeeded) {
        onPaymentDone?.call();
      } else {
        onPaymentFailed?.call();
      }
    });
  }

  cancel() {
    if (timer?.isActive == true) {
      timer?.cancel();
    }
    timer = null;
  }
}
