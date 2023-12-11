import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/vault/vault_enums.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class VaultItem extends StatelessWidget {
  final PaymentAccount vault;
  const VaultItem({
    super.key,
    required this.vault,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return InkWell(
      onLongPress: () async {
        Vibrate.feedback(FeedbackType.light);
        await Clipboard.setData(
          ClipboardData(text: vault.accountInfo?.address ?? ''),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.common.copiedToClipboard,
              style: Typo.medium.copyWith(color: colorScheme.onPrimary),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: LemonColor.snackBarSuccess,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(
            LemonRadius.small,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Vault name and address
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      vault.title ?? '',
                      style: Typo.medium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: Spacing.extraSmall),
                          child: Assets.icons.icMetamask.svg(
                            width: Sizing.small / 2,
                            height: Sizing.small / 2,
                          ),
                        ),
                        if (vault.accountInfo?.pending == true)
                          Text(
                            t.vault.deploying,
                            style: Typo.small.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        if (vault.accountInfo?.pending != true &&
                            vault.accountInfo?.address?.isNotEmpty == true)
                          Text(
                            Web3Utils.formatIdentifier(
                              vault.accountInfo?.address ?? '',
                              length: 6,
                            ),
                            style: Typo.small.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                // vault balance
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '\$0.0',
                      style: Typo.medium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      t.vault.vaultInfo.balance,
                      style: Typo.small.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Spacing.smMedium),
            // more vault info
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChainQuery(
                    chainId: vault.accountInfo?.network ?? '',
                    builder: (chain, {required isLoading}) => _VaultInfoItem(
                      title: t.vault.vaultInfo.chain,
                      child: Flexible(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(LemonRadius.normal),
                              child: CachedNetworkImage(
                                imageUrl: chain?.logoUrl ?? '',
                                errorWidget: (_, __, ___) =>
                                    const SizedBox.shrink(),
                                placeholder: (_, __) => const SizedBox.shrink(),
                                width: Sizing.xSmall,
                                height: Sizing.xSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const Spacer(),
                  // const Spacer(),
                  SizedBox(width: Spacing.extraSmall),
                  _VaultInfoItem(
                    title: t.vault.vaultInfo.assets,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [1, 2, 3]
                          .map(
                            (item) => Container(
                              width: Sizing.xSmall,
                              height: Sizing.xSmall,
                              margin: EdgeInsets.only(right: 2.w),
                              decoration: BoxDecoration(
                                color: colorScheme.onPrimary.withOpacity(0.06),
                                borderRadius:
                                    BorderRadius.circular(LemonRadius.normal),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(width: Spacing.extraSmall),
                  _VaultInfoItem(
                    title: t.vault.vaultInfo.members(
                      n: (vault.accountInfo?.owners ?? []).length,
                    ),
                    child: Text(
                      (vault.accountInfo?.owners ?? []).length.toString(),
                      style: Typo.mediumPlus.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VaultInfoItem extends StatelessWidget {
  final String title;
  final Widget child;

  const _VaultInfoItem({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(Spacing.xSmall),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            SizedBox(height: Spacing.superExtraSmall),
            Text(
              title,
              style: Typo.xSmall.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
