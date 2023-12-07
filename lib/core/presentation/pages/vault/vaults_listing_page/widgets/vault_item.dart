import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VaultItem extends StatelessWidget {
  final PaymentAccount vault;
  const VaultItem({
    super.key,
    required this.vault,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
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
                      Text(
                        Web3Utils.formatIdentifier(
                          vault.accountInfo?.address ?? '',
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
                    '\$32K',
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
          // TODO: temporary hide
          // SizedBox(height: Spacing.smMedium),
          // // more vault info
          // IntrinsicHeight(
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       _VaultInfoItem(
          //         title: t.vault.vaultInfo.chain,
          //         child: const SizedBox.shrink(),
          //       ),
          //       SizedBox(width: Spacing.extraSmall),
          //       _VaultInfoItem(
          //         title: t.vault.vaultInfo.assets,
          //         child: const SizedBox.shrink(),
          //       ),
          //       SizedBox(width: Spacing.extraSmall),
          //       _VaultInfoItem(
          //         title: t.vault.vaultInfo.members,
          //         child: Text(
          //           '11',
          //           style: Typo.mediumPlus.copyWith(
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

// TODO: temporary hide
// class _VaultInfoItem extends StatelessWidget {
//   final String title;
//   final Widget child;

//   const _VaultInfoItem({
//     required this.title,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(Spacing.xSmall),
//         decoration: BoxDecoration(
//           color: colorScheme.secondaryContainer,
//           borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             child,
//             SizedBox(height: Spacing.superExtraSmall),
//             Text(
//               title,
//               style: Typo.xSmall.copyWith(
//                 color: colorScheme.onSecondary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
