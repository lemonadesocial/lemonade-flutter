import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/reward/entities/reward_token.dart';
import 'package:app/core/domain/reward/entities/ticket_type_reward.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/entities/token_reward_vault.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GuestEventDetailTokenRewardsList extends StatefulWidget {
  final List<TokenRewardSetting> rewardSettings;
  final List<EventTicketType> ticketTypes;
  const GuestEventDetailTokenRewardsList({
    super.key,
    required this.rewardSettings,
    required this.ticketTypes,
  });

  @override
  State<GuestEventDetailTokenRewardsList> createState() =>
      _GuestEventDetailTokenRewardsListState();
}

class _GuestEventDetailTokenRewardsListState
    extends State<GuestEventDetailTokenRewardsList> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<(TicketTypeReward, RewardToken?, TokenRewardVault?, EventTicketType?)>
      get ticketTypeRewards => widget.rewardSettings.expand(
            (setting) {
              return (setting.rewards ?? []).map((r) {
                final token =
                    (setting.vaultExpanded?.tokens ?? []).firstWhereOrNull(
                  (t) => t.address == setting.currencyAddress,
                );
                final ticketType = widget.ticketTypes.firstWhereOrNull(
                  (t) => t.id == r.ticketType,
                );
                return (r, token, setting.vaultExpanded, ticketType);
              });
            },
          ).toList();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: Sizing.medium * 2,
          child: PageView.builder(
            controller: controller,
            padEnds: false,
            itemCount: ticketTypeRewards.length,
            itemBuilder: (context, index) {
              final reward = ticketTypeRewards[index].$1;
              final token = ticketTypeRewards[index].$2;
              final vault = ticketTypeRewards[index].$3;
              final ticketType = ticketTypeRewards[index].$4;
              return Padding(
                padding: EdgeInsets.only(right: Spacing.superExtraSmall / 2),
                child: _TokenRewardItem(
                  reward: reward,
                  token: token,
                  vault: vault,
                  ticketType: ticketType,
                ),
              );
            },
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        SmoothPageIndicator(
          controller: controller,
          count: ticketTypeRewards.length,
          effect: ExpandingDotsEffect(
            dotWidth: 12.w,
            dotHeight: 4.w,
            activeDotColor: colorScheme.onPrimary,
            dotColor: LemonColor.chineseBlack,
            expansionFactor: 1.1,
          ),
        ),
      ],
    );
  }
}

class _TokenRewardItem extends StatelessWidget {
  const _TokenRewardItem({
    required this.reward,
    required this.token,
    required this.vault,
    required this.ticketType,
  });

  final TicketTypeReward reward;
  final RewardToken? token;
  final TokenRewardVault? vault;
  final EventTicketType? ticketType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Spacing.xSmall),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          LemonNetworkImage(
            imageUrl: token?.iconUrl ?? '',
            width: Sizing.medium,
            height: Sizing.medium,
            placeholder: Container(
              decoration: BoxDecoration(
                color: LemonColor.chineseBlack,
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                border: Border.all(
                  color: colorScheme.outlineVariant,
                ),
              ),
              width: Sizing.medium,
              height: Sizing.medium,
              child: Center(
                child: ThemeSvgIcon(
                  color: LemonColor.paleViolet,
                  builder: (filter) => Assets.icons.icGift.svg(
                    colorFilter: filter,
                    width: Sizing.small,
                    height: Sizing.small,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    t.event.tokenReward.currencyReward(
                      currency: token?.symbol ?? '',
                    ),
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: Spacing.superExtraSmall),
                  ChainQuery(
                    chainId: vault?.network ?? '',
                    builder: (
                      chain, {
                      required isLoading,
                    }) {
                      return LemonNetworkImage(
                        imageUrl: chain?.logoUrl ?? '',
                        width: Sizing.mSmall,
                        height: Sizing.mSmall,
                      );
                    },
                  ),
                ],
              ),
              Text(
                t.event.tokenReward.onClaimingTickets(
                  ticketType: ticketType?.title ?? '',
                ),
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
