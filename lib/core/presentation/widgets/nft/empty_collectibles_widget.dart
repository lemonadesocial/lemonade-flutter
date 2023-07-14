import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EmptyCollectibles extends StatelessWidget {
  const EmptyCollectibles({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        children: [
          Assets.icons.noCollectible.svg(),
          SizedBox(height: Spacing.smMedium),
          Text(
            t.nft.noCollectible,
            style: Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
