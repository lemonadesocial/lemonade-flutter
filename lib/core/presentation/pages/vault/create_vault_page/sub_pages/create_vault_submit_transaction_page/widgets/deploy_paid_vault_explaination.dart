import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class DeployPaidVaultExplanation extends StatelessWidget {
  const DeployPaidVaultExplanation({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          t.vault.createVault.reachFreeLimit,
          style: Typo.medium.copyWith(color: colorScheme.onSecondary),
        ),
      ],
    );
  }
}
