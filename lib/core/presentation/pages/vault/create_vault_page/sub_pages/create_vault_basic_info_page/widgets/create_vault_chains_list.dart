import 'dart:math';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateVaultChainsList extends StatelessWidget {
  const CreateVaultChainsList({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.vault.createVault.selectChain,
          style: Typo.mediumPlus.copyWith(color: colorScheme.onSecondary),
        ),
        SizedBox(
          height: Spacing.medium,
        ),
        Wrap(
          runSpacing: Spacing.extraSmall,
          spacing: Spacing.extraSmall,
          children: List.filled(10, 0).map((item) {
            final a = Random().nextInt(10);
            // mock data
            final chainMetadata =
                Web3Utils.getNetworkMetadataById(a.isEven ? "137" : "5");
            return Container(
              height: 42.w,
              padding: EdgeInsets.symmetric(horizontal: Spacing.small),
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                borderRadius: BorderRadius.circular(LemonRadius.button),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  chainMetadata?.icon ?? const SizedBox.shrink(),
                  SizedBox(width: Spacing.extraSmall),
                  Text(chainMetadata?.displayName ?? ''),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
