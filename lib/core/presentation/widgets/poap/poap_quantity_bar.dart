import 'package:app/core/domain/badge/entities/badge_entities.dart' as badgeEntities;
import 'package:app/core/domain/poap/input/poap_input.dart';
import 'package:app/core/domain/poap/poap_repository.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
  
final _poapRepository = getIt<PoapRepository>();

class PoapQuantityBar extends StatelessWidget {
  const PoapQuantityBar({
    super.key,
    required this.badge,
  });

  final badgeEntities.Badge badge;
  
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final smallTextStyle = Typo.small.copyWith(color: colorScheme.onSurfaceVariant);

    return FutureBuilder(
      future: _poapRepository.getPoapViewSupply(
        input: GetPoapViewSupplyInput(
          network: badge.network ?? '',
          address: badge.contract?.toLowerCase() ?? '',
        ),
      ),
      builder: (context, snapshot) {
        final poapViewSupply = snapshot.data?.fold((l) => null, (poapView) => poapView);
        final claimedQuantity = poapViewSupply?.claimedQuantity ?? 0;
        final quantity = poapViewSupply?.quantity ?? 0;

        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: quantity == 0 ? 0 : claimedQuantity / quantity,
                color: LemonColor.paleViolet,
                backgroundColor: LemonColor.paleViolet18,
                minHeight: 2,
              ),
            ),
            SizedBox(height: Spacing.extraSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$claimedQuantity ${t.nft.claimed}', style: smallTextStyle),
                Text('$quantity', style: smallTextStyle),
              ],
            ),
          ],
        );
      },
    );
  }
}
