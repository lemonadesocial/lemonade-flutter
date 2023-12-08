import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateVaultChainsList extends StatelessWidget {
  final Chain? selectedChain;
  final Function(Chain selectedChain)? onSelectChain;

  const CreateVaultChainsList({
    super.key,
    this.selectedChain,
    this.onSelectChain,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder(
      future: getIt<Web3Repository>().getChainsList(),
      builder: (context, snapshot) {
        final chains = snapshot.data?.getOrElse(() => []) ?? [];
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
              children: chains.map((chain) {
                final selected = chain.chainId == selectedChain?.chainId;
                return InkWell(
                  onTap: () => onSelectChain?.call(chain),
                  child: Container(
                    height: 42.w,
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                    decoration: BoxDecoration(
                      color: selected
                          ? LemonColor.paleViolet18
                          : LemonColor.atomicBlack,
                      borderRadius: BorderRadius.circular(LemonRadius.button),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (chain.logoUrl != null) ...[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(LemonRadius.normal),
                            child: CachedNetworkImage(
                              width: Sizing.xSmall,
                              height: Sizing.xSmall,
                              imageUrl: chain.logoUrl!,
                              placeholder: (_, __) => const SizedBox.shrink(),
                              errorWidget: (_, __, ___) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                          SizedBox(width: Spacing.extraSmall),
                        ],
                        Text(chain.name ?? ''),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
