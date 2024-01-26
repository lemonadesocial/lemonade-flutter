import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/application/event/get_event_reward_uses_bloc/get_event_reward_uses_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_reward_use.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/domain/event/repository/event_reward_repository.dart';
import 'package:app/core/presentation/widgets/event/horizontal_rewards_list.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ClaimRewardsListing extends StatelessWidget {
  const ClaimRewardsListing({super.key, required this.userId});
  final String userId;

  Future<void> onToggleClaim(
    BuildContext context,
    Reward reward,
    int index,
  ) async {
    String eventId = context.watch<GetEventDetailBloc>().state.maybeWhen(
          fetched: (event) => event.id ?? '',
          orElse: () => '',
        );
    Vibrate.feedback(FeedbackType.light);
    List<EventRewardUse>? eventRewardUses =
        context.read<GetEventRewardUsesBloc>().state.eventRewardUses;
    bool? exist = eventRewardUses?.any(
      (item) => item.rewardNumber == index && item.rewardId == reward.id,
    );
    showFutureLoadingDialog(
      context: context,
      future: () async {
        final result =
            await getIt<EventRewardRepository>().updateEventRewardUse(
          input: Input$UpdateEventRewardUseInput(
            event: eventId,
            user: userId,
            reward_id: reward.id ?? '',
            reward_number: index.toDouble(),
            active: exist == false,
          ),
        );
        if (result.isRight()) {
          context.read<GetEventRewardUsesBloc>().add(
                GetEventRewardUsesEvent.getEventRewardUses(
                  eventId: eventId,
                  userId: userId,
                  showLoading: false,
                ),
              );
        }
      },
    );
  }

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
                HorizontalRewardsList(
                  reward: reward,
                  onToggleItem: onToggleClaim,
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
