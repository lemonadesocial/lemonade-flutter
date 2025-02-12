import 'package:app/core/domain/reward/entities/reward_token.dart';
import 'package:app/core/domain/reward/entities/ticket_type_reward.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class TokenRewardItemWidget extends StatelessWidget {
  final TokenRewardSetting tokenRewardSetting;
  const TokenRewardItemWidget({
    super.key,
    required this.tokenRewardSetting,
  });

  String? get network => tokenRewardSetting.vaultExpanded?.network;

  RewardToken? get rewardToken =>
      tokenRewardSetting.vaultExpanded?.tokens?.firstWhereOrNull(
        (element) => element.address == tokenRewardSetting.currencyAddress,
      );

  TicketTypeReward? get reward => tokenRewardSetting.rewards?.firstOrNull;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final amount = Web3Utils.formatCryptoCurrency(
      BigInt.parse(reward?.rewardPerTicket ?? '0'),
      currency: rewardToken?.symbol ?? '',
      decimals: rewardToken?.decimals ?? 0,
    );
    return ChainQuery(
      chainId: network ?? '',
      builder: (
        chain, {
        required bool isLoading,
      }) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LemonNetworkImage(
              imageUrl: rewardToken?.iconUrl ?? '',
              width: Sizing.small,
              height: Sizing.small,
            ),
            SizedBox(
              width: Spacing.small,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      amount,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: Spacing.extraSmall,
                    ),
                    LemonNetworkImage(
                      imageUrl: chain?.logoUrl ?? '',
                      borderRadius: BorderRadius.circular(
                        Sizing.xSmall,
                      ),
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                    ),
                  ],
                ),
                Text(
                  t.event.tokenReward.rewardPerTicket(
                    amount: amount,
                  ),
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
