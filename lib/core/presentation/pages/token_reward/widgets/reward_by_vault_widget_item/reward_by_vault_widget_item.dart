import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/reward/entities/reward_token.dart';
import 'package:app/core/domain/reward/entities/ticket_type_reward.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/entities/token_reward_vault.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardByVaultWidgetItem extends StatelessWidget {
  final List<TokenRewardSetting> tokenRewardSettings;
  const RewardByVaultWidgetItem({
    super.key,
    required this.tokenRewardSettings,
    required this.onTapClaim,
  });

  final Function(TokenRewardVault) onTapClaim;

  TokenRewardVault? get vault => tokenRewardSettings.firstOrNull?.vaultExpanded;

  List<(TicketTypeReward, RewardToken?)> get rewardsWithTokens =>
      tokenRewardSettings
          .expand(
            (setting) =>
                (setting.rewards ?? <TicketTypeReward>[]).map((reward) {
              final targetToken = vault?.tokens?.firstWhereOrNull(
                (token) => token.address == setting.currencyAddress,
              );
              return (reward, targetToken);
            }),
          )
          .toList();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return ChainQuery(
      chainId: vault?.network ?? '',
      builder: (
        chain, {
        required bool isLoading,
      }) {
        return Container(
          decoration: BoxDecoration(
            color: LemonColor.atomicBlack,
            borderRadius: BorderRadius.circular(
              LemonRadius.medium,
            ),
            border: Border.all(
              color: colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(Spacing.small),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LemonNetworkImage(
                      imageUrl: chain?.logoUrl ?? '',
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                    ),
                    SizedBox(
                      width: Spacing.small,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chain?.name ?? '',
                            style: Typo.medium.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${rewardsWithTokens.length} ${t.event.rewardsCount(n: rewardsWithTokens.length)}',
                            style: Typo.small.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Sizing.medium,
                      child: BlocBuilder<WalletBloc, WalletState>(
                        builder: (context, walletState) {
                          final walletConnected =
                              walletState.activeSession != null;
                          if (!walletConnected) {
                            return ConnectWalletButton(
                              builder: (onPressConnect, state) {
                                return LinearGradientButton.primaryButton(
                                  radius:
                                      BorderRadius.circular(LemonRadius.normal),
                                  label: t.common.actions.connect,
                                  onTap: () => onPressConnect(context),
                                );
                              },
                            );
                          }
                          return LinearGradientButton.primaryButton(
                            radius: BorderRadius.circular(LemonRadius.normal),
                            label: t.common.actions.claim,
                            onTap: () {
                              if (vault == null) return;
                              onTapClaim(vault!);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: colorScheme.outlineVariant,
                height: 1.w,
              ),
              ListView.separated(
                padding: EdgeInsets.all(Spacing.small),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final reward = rewardsWithTokens[index].$1;
                  final token = rewardsWithTokens[index].$2;
                  return _TokenItem(
                    reward: reward,
                    token: token,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: Spacing.xSmall,
                ),
                itemCount: rewardsWithTokens.length,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TokenItem extends StatelessWidget {
  final TicketTypeReward reward;
  final RewardToken? token;
  const _TokenItem({
    required this.reward,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final amount = Web3Utils.formatCryptoCurrency(
      BigInt.parse(reward.rewardPerTicket ?? '0'),
      currency: token?.symbol ?? '',
      decimals: token?.decimals ?? 0,
    );
    return Row(
      children: [
        LemonNetworkImage(
          imageUrl: token?.iconUrl ?? '',
          width: Sizing.xSmall,
          height: Sizing.xSmall,
        ),
        SizedBox(
          width: Spacing.small,
        ),
        Text(
          amount,
          style: Typo.medium.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
