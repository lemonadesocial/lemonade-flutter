import 'dart:async';

import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class WaitForPaymentNotificationHandler {
  Timer? timer;

  start(BuildContext context) {
    timer = Timer(const Duration(minutes: 3), () {
      final t = Translations.of(context);
      final colorScheme = Theme.of(context).colorScheme;

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return LemonAlertDialog(
            buttonLabel: t.common.actions.ok,
            child: Text(
              t.event.eventPayment.paymentNotificationTimeoutMessage,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            onClose: () async {
              AutoRouter.of(context).root.popUntilRouteWithPath('/events');
            },
          );
        },
      );
    });
  }

  cancel() {
    if (timer?.isActive == true) {
      timer?.cancel();
    }
    timer = null;
  }
}
