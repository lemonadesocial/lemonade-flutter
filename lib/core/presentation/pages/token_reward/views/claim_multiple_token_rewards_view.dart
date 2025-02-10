import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/entities/token_reward_vault.dart';
import 'package:app/core/presentation/pages/token_reward/widgets/reward_by_vault_widget_item/reward_by_vault_widget_item.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class ClaimMultipleTokenRewardsView extends StatelessWidget {
  final Function(TokenRewardVault) onTapClaim;
  final VoidCallback onTapDoItLater;
  const ClaimMultipleTokenRewardsView({
    super.key,
    required this.rewardSettingsGroupByVault,
    required this.onTapClaim,
    required this.onTapDoItLater,
  });

  final Map<TokenRewardVault?, List<TokenRewardSetting>>
      rewardSettingsGroupByVault;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.event.tokenReward.claimRewards,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.event.tokenReward.claimYourRewardScreenDescription,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: Spacing.medium),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return RewardByVaultWidgetItem(
                          onTapClaim: (vault) {
                            onTapClaim(vault);
                          },
                          tokenRewardSettings: rewardSettingsGroupByVault.values
                              .elementAt(index),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: Spacing.small),
                      itemCount: rewardSettingsGroupByVault.length,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(Spacing.small),
                child: LinearGradientButton.secondaryButton(
                  mode: GradientButtonMode.light,
                  label: t.common.actions.doItLater,
                  onTap: onTapDoItLater,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
