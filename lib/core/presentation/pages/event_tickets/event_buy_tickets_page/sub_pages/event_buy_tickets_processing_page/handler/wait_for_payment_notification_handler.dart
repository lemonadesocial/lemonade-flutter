import 'dart:async';

import 'package:app/core/domain/payment/entities/payment.dart';
import 'package:app/core/domain/payment/input/get_payment_input/get_payment_input.dart';
import 'package:app/core/domain/payment/payment_repository.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';

class WaitForPaymentNotificationHandler {
  Timer? timer;
  int _remainingAttempt = 30;

  static get maxDurationToWaitForNotification => const Duration(minutes: 5);

  static get delayIntervalDuration => const Duration(seconds: 5);

  Future<Payment?> _checkPayment(String paymentId) async {
    int remainingAttempt = 20;
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
      if (payment?.state == Enum$NewPaymentState.succeeded ||
          payment?.state == Enum$NewPaymentState.await_capture) {
        return payment;
      }
      remainingAttempt--;
    }
    return payment;
  }

  start(
    BuildContext context, {
    required String paymentId,
    Function(Payment? payment)? onPaymentDone,
    Function()? onPaymentFailed,
  }) async {
    if (_remainingAttempt == 0) {
      _remainingAttempt = 30;
      onPaymentFailed?.call();
      return;
    }
    timer = Timer(const Duration(seconds: 15), () async {
      final payment = await _checkPayment(paymentId);

      if (payment?.state == Enum$NewPaymentState.succeeded ||
          payment?.state == Enum$NewPaymentState.await_capture) {
        onPaymentDone?.call(payment);
      } else {
        _remainingAttempt--;
        start(
          context,
          paymentId: paymentId,
          onPaymentDone: onPaymentDone,
          onPaymentFailed: onPaymentFailed,
        );
      }
    });
  }

  void startWithCrypto(
    BuildContext context, {
    required String chainId,
    required String txHash,
    required String paymentId,
    Function(Payment? payment)? onPaymentDone,
    Function()? onPaymentFailed,
  }) async {
    if (_remainingAttempt == 0) {
      _remainingAttempt = 30;
      onPaymentFailed?.call();
      return;
    }
    final getChainResult =
        await getIt<Web3Repository>().getChainById(chainId: chainId);
    final chain = getChainResult.getOrElse(() => null);
    final waitTime = (chain?.blockTime?.toInt() ?? 1) *
        (chain?.safeConfirmations?.toInt() ?? 1);
    timer = Timer(Duration(seconds: waitTime * 2), () async {
      final receipt = await Web3Utils.waitForReceipt(
        rpcUrl: chain?.rpcUrl ?? '',
        txHash: txHash,
        deplayDuration: delayIntervalDuration,
      );
      final payment = await _checkPayment(paymentId);

      if (receipt?.status == true &&
          (payment?.state == Enum$NewPaymentState.succeeded ||
              payment?.state == Enum$NewPaymentState.await_capture)) {
        onPaymentDone?.call(payment);
      } else {
        _remainingAttempt--;
        startWithCrypto(
          context,
          chainId: chainId,
          txHash: txHash,
          paymentId: paymentId,
          onPaymentDone: onPaymentDone,
          onPaymentFailed: onPaymentFailed,
        );
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
