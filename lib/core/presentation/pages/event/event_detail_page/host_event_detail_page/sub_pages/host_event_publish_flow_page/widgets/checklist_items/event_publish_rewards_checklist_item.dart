import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/reward.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/host_event_publish_flow_page/widgets/checklist_items/checklist_item_base_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventPublishRewardsChecklistItem extends StatelessWidget {
  final bool fulfilled;
  final Event event;

  const EventPublishRewardsChecklistItem({
    super.key,
    required this.fulfilled,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return CheckListItemBaseWidget(
      onTap: () => AutoRouter.of(context).push(
        const EventRewardSettingRoute(),
      ),
      title: t.event.eventPublish.addRewards,
      icon: Assets.icons.icBadgeReward,
      fulfilled: fulfilled,
      child: event.rewards?.isNotEmpty == true
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...(event.rewards ?? []).asMap().entries.map((entry) {
                  final isLast = entry.key == (event.rewards ?? []).length - 1;
                  return _RewardItem(
                    reward: entry.value,
                    isLast: isLast,
                  );
                }),
              ],
            )
          : null,
    );
  }
}

class _RewardItem extends StatelessWidget {
  final Reward reward;
  final bool isLast;
  const _RewardItem({
    required this.reward,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final fullIconUrl = '${AppConfig.assetPrefix}${reward.iconUrl}';
    return InkWell(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: isLast ? 0 : Spacing.small,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3.w),
              child: Container(
                width: Sizing.xSmall,
                height: Sizing.xSmall,
                color: LemonColor.atomicBlack,
                child: CachedNetworkImage(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  imageUrl: fullIconUrl,
                  placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                  errorWidget: (_, __, ___) =>
                      ImagePlaceholder.defaultPlaceholder(),
                ),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
            Expanded(
              flex: 1,
              child: Text.rich(
                TextSpan(
                  text: reward.title ?? '',
                  style: Typo.medium.copyWith(color: colorScheme.onSecondary),
                ),
              ),
            ),
            if (reward.limitPer != null)
              Text(
                t.event.rewardSetting.rewardsPerGuest(
                  count: reward.limitPer.toString(),
                ),
                style: Typo.medium.copyWith(color: colorScheme.onSecondary),
              ),
          ],
        ),
      ),
    );
  }
}
