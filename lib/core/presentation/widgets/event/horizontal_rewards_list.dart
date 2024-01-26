import 'package:app/core/application/event/get_event_reward_uses_bloc/get_event_reward_uses_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event_reward_use.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalRewardsList extends StatelessWidget {
  const HorizontalRewardsList({
    super.key,
    required this.reward,
    this.onToggleItem,
  });
  final Reward reward;
  final Function(BuildContext context, Reward reward, int index)? onToggleItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizing.regular,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: reward.limitPer,
        itemBuilder: (context, index) {
          final fullIconUrl = '${AppConfig.assetPrefix}${reward.iconUrl}';
          return BlocBuilder<GetEventRewardUsesBloc, GetEventRewardUsesState>(
            builder: (context, state) {
              List<EventRewardUse>? eventRewardUses = state.eventRewardUses;
              bool? exist = eventRewardUses?.any(
                (item) =>
                    item.rewardNumber == index && item.rewardId == reward.id,
              );
              return InkWell(
                onTap: () {
                  if (onToggleItem != null) {
                    onToggleItem!(context, reward, index);
                  }
                },
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
