import 'package:app/core/presentation/widgets/common/dialog/lemon_alert_dialog.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class DiscardSelectedTicketsWarning extends StatelessWidget {
  final Function()? onConfirm;
  const DiscardSelectedTicketsWarning({
    super.key,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return LemonAlertDialog(
      closable: true,
      onClose: () {
        onConfirm?.call();
        Navigator.of(context).pop();
      },
      title: t.event.eventBuyTickets.discardSelectionWarning.title,
      buttonLabel: t.event.eventBuyTickets.discardSelectionWarning.buttonLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Spacing.xSmall),
          Text(
            t.event.eventBuyTickets.discardSelectionWarning.description,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
