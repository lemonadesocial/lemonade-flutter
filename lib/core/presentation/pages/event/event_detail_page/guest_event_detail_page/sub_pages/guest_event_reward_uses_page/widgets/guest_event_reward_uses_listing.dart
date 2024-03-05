import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_reward_uses_bloc/get_event_reward_uses_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_reward_use.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestEventRewardUsesListing extends StatelessWidget {
  const GuestEventRewardUsesListing({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    Event event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event,
          orElse: () => Event(),
        );
    List<Reward> rewards = event.rewards ?? [];
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
                BlocBuilder<GetEventRewardUsesBloc, GetEventRewardUsesState>(
                  builder: (context, state) {
                    List<EventRewardUse>? eventRewardUses =
                        state.eventRewardUses;
                    final totalCount = eventRewardUses
                            ?.where(
                              (element) => element.rewardId == reward.id,
                            )
                            .length ??
                        0;
                    final leftCount = reward.limitPer! - totalCount;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.smMedium,
                        vertical: Spacing.small,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            reward.title ?? '',
                            style: Typo.mediumPlus,
                          ),
                          SizedBox(
                            width: Spacing.smMedium,
                          ),
                          Text(
                            t.common.countLeft(count: leftCount),
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // HorizontalRewardsList(
                //   reward: reward,
                // ),
              ],
            ),
          );
        },
        childCount: rewards.length,
      ),
    );
  }
}
