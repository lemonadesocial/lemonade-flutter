import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/claim_rewards_bloc/claim_rewards_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event_reward_use.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClaimRewardsListing extends StatelessWidget {
  const ClaimRewardsListing({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    List<Reward> rewards = context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.rewards,
              orElse: () => [],
            ) ??
        [];
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, sectionIndex) {
          final reward = rewards[sectionIndex];
          return Padding(
            padding: EdgeInsets.only(
              top: sectionIndex == 0 ? Spacing.superExtraSmall : Spacing.large,
            ),
            child: Column(
              children: [
                BlocBuilder<ClaimRewardsBloc, ClaimRewardsState>(
                  builder: (context, state) {
                    List<EventRewardUse>? eventRewardUses =
                        state.eventRewardUses;
                    final totalCount = eventRewardUses
                            ?.where(
                              (element) => element.rewardId == reward.id,
                            )
                            .length ??
                        0;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.smMedium,
                        vertical: Spacing.small,
                      ),
                      child: Row(
                        children: [
                          Text(
                            reward.title ?? '',
                            style: Typo.mediumPlus,
                          ),
                          SizedBox(
                            width: Spacing.smMedium,
                          ),
                          Text(
                            '$totalCount/${reward.limitPer} ${t.event.claimed}',
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                HorizontalListWidget(
                  reward: reward,
                ),
              ],
            ),
          );
        },
        childCount: rewards.length,
      ),
    );
  }
}

class HorizontalListWidget extends StatelessWidget {
  const HorizontalListWidget({super.key, required this.reward});
  final Reward reward;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizing.regular,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: reward.limitPer,
        itemBuilder: (context, index) {
          final fullIconUrl = '${AppConfig.assetPrefix}${reward.iconUrl}';
          return BlocBuilder<ClaimRewardsBloc, ClaimRewardsState>(
            builder: (context, state) {
              List<EventRewardUse>? eventRewardUses = state.eventRewardUses;
              bool? exist = eventRewardUses?.any(
                (item) =>
                    item.rewardNumber == index && item.rewardId == reward.id,
              );
              return InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                  child: Opacity(
                    opacity: exist == true ? 0.5 : 1,
                    child: Container(
                      width: Sizing.regular,
                      height: Sizing.regular,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(LemonRadius.large),
                        border: Border.all(
                          width: 2.w,
                          color: Colors.yellow,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          LemonRadius.large,
                        ),
                        child: CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: fullIconUrl,
                          placeholder: (_, __) =>
                              ImagePlaceholder.defaultPlaceholder(),
                          errorWidget: (_, __, ___) =>
                              ImagePlaceholder.defaultPlaceholder(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
