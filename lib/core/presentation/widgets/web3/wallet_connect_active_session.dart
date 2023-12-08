import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class WalletConnectActiveSessionWidget extends StatelessWidget {
  final String? title;
  final SessionData activeSession;
  final Function()? onPressDisconnect;

  const WalletConnectActiveSessionWidget({
    super.key,
    this.title,
    required this.activeSession,
    this.onPressDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final sessionAccount =
        activeSession.namespaces.entries.first.value.accounts.first;
    final userWalletAddress = NamespaceUtils.getAccount(sessionAccount);
    String displayAddress = Web3Utils.formatIdentifier(userWalletAddress);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: LemonColor.chineseBlack,
            borderRadius: BorderRadius.circular(
              LemonRadius.extraSmall,
            ),
          ),
          width: Sizing.medium,
          height: Sizing.medium,
          child: Center(
            child: Assets.icons.icMetamask.svg(
              width: Sizing.xSmall,
              height: Sizing.xSmall,
            ),
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: Typo.small.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            Text(displayAddress),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () => onPressDisconnect?.call(),
          child: Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.09),
              borderRadius: BorderRadius.circular(LemonRadius.normal),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icClose.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
