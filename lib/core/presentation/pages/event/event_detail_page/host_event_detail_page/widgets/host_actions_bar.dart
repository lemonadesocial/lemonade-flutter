import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/scan_qr_code/widgets/claim_rewards_modal.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HostActionsBar extends StatelessWidget {
  const HostActionsBar({
    super.key,
    required this.event,
  });

  final Event event;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return ClaimRewardsModal(
                onClose: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
          // AutoRouter.of(context).navigate(
          //   ScanQRCodeRoute(
          //     event: event,
          //   ),
          // );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code, color: Colors.white),
            SizedBox(width: Spacing.extraSmall),
            Text(t.event.scanQR.scan, style: Typo.mediumPlus),
          ],
        ),
      ),
    );
  }
}
