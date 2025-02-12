import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/entities/token_reward_vault.dart';
import 'package:app/core/presentation/widgets/animation/circular_animation_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ClaimSingleTokenRewardView extends StatelessWidget {
  const ClaimSingleTokenRewardView({
    super.key,
    required this.rewardSettingByVault,
    required this.ticketCount,
    required this.walletConnected,
    required this.onTapClaim,
    required this.onTapDoItLater,
  });

  final (TokenRewardVault?, List<TokenRewardSetting>) rewardSettingByVault;
  final int ticketCount;
  final bool walletConnected;
  final VoidCallback onTapClaim;
  final VoidCallback onTapDoItLater;

  List<String> get displayRewardAmounts {
    final vault = rewardSettingByVault.$1;
    return rewardSettingByVault.$2.map((setting) {
      final amount = setting.rewards?.first.rewardPerTicket;
      final token = vault?.tokens?.firstWhereOrNull(
        (token) => token.address == setting.currencyAddress,
      );
      return Web3Utils.formatCryptoCurrency(
        BigInt.parse(amount ?? '0'),
        currency: token?.symbol ?? '',
        decimals: token?.decimals ?? 18,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            const Spacer(),
            const Spacer(),
            CircularAnimationWidget(
              icon: Assets.icons.icLime.svg(),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                  child: Column(
                    children: [
                      Text(
                        t.event.tokenReward.claimYourReward,
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Spacing.superExtraSmall),
                      Text(
                        t.event.tokenReward.claimYourRewardDescription(
                          amount: displayRewardAmounts.join(', '),
                        ),
                        textAlign: TextAlign.center,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                      SizedBox(height: Spacing.medium),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: colorScheme.outline,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      if (walletConnected)
                        LinearGradientButton.primaryButton(
                          label: t.event.tokenReward.claimRewards,
                          onTap: onTapClaim,
                        ),
                      if (!walletConnected) const ConnectWalletButton(),
                      SizedBox(height: Spacing.small),
                      LinearGradientButton.secondaryButton(
                        mode: GradientButtonMode.light,
                        label: t.common.actions.doItLater,
                        onTap: onTapDoItLater,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
