import 'package:app/core/config.dart';
import 'package:app/core/domain/cubejs/entities/cube_reward_use/cube_reward_use.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/shimmer/shimmer.dart';
import 'package:app/core/service/cubejs_service/cubejs_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardRewardsStanding extends StatefulWidget {
  final Event event;
  const DashboardRewardsStanding({
    super.key,
    required this.event,
  });

  @override
  State<DashboardRewardsStanding> createState() =>
      _DashboardRewardsStandingState();
}

class _DashboardRewardsStandingState extends State<DashboardRewardsStanding> {
  String getRewardIconUrl(String? rewardId) {
    return (widget.event.rewards ?? [])
            .firstWhereOrNull((element) => element.id == rewardId)
            ?.iconUrl ??
        '';
  }

  String getRewardTitle(String? rewardId) {
    return (widget.event.rewards ?? [])
            .firstWhereOrNull((element) => element.id == rewardId)
            ?.title ??
        '';
  }

  int totalRedeems(List<CubeRewardUse> rewardUses) {
    return rewardUses.fold(
      0,
      (previousValue, element) => previousValue + (element.count ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder(
      future: CubeJsService(eventId: widget.event.id ?? '').query(
        body: {
          "measures": ["EventRewardUses.count"],
          "dimensions": ["EventRewardUses.rewardId"],
        },
      ),
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final rewardUses = snapshot.data?.fold(
              (l) => [].cast<CubeRewardUse>(),
              (result) =>
                  result.map((json) => CubeRewardUse.fromJson(json)).toList(),
            ) ??
            [];
        final rewardsUsesByRewardId = groupBy(
          rewardUses,
          (reward) => reward.rewardId,
        );

        if (isLoading) {
          return SliverList.separated(
            itemCount: 3,
            itemBuilder: (context, index) {
              return SizedBox(
                height: Sizing.medium,
                child: Shimmer.fromColors(
                  baseColor: colorScheme.background,
                  highlightColor: colorScheme.secondaryContainer,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: Spacing.superExtraSmall,
            ),
          );
        }

        if (rewardUses.isEmpty) {
          return const SliverToBoxAdapter(
            child: EmptyList(),
          );
        }

        return SliverList.separated(
          itemCount: rewardsUsesByRewardId.entries.length,
          itemBuilder: (context, index) {
            final isFirst = index == 0;
            final isLast = index == rewardsUsesByRewardId.entries.length - 1;
            final rewardId = rewardsUsesByRewardId.entries.toList()[index].key;
            final totalRedeemsWithRewardId = totalRedeems(
              rewardsUsesByRewardId.entries.toList()[index].value,
            );
            final rewardTitle = getRewardTitle(rewardId);

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.smMedium,
                vertical: Spacing.extraSmall,
              ),
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
                  ),
                  topRight: Radius.circular(
                    isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
                  ),
                  bottomLeft: Radius.circular(
                    isLast ? LemonRadius.medium : LemonRadius.extraSmall,
                  ),
                  bottomRight: Radius.circular(
                    isLast ? LemonRadius.medium : LemonRadius.extraSmall,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: Sizing.medium,
                    height: Sizing.medium,
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(LemonRadius.xSmall),
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl:
                            '${AppConfig.assetPrefix}${getRewardIconUrl(rewardId)}',
                        placeholder: (_, __) =>
                            ImagePlaceholder.defaultPlaceholder(),
                        errorWidget: (_, __, ___) =>
                            ImagePlaceholder.defaultPlaceholder(),
                        width: 18.w,
                        height: 18.w,
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Expanded(
                    child: Text(
                      rewardTitle,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    '$totalRedeemsWithRewardId ${t.event.eventDashboard.reward.redeems}',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: Spacing.superExtraSmall,
          ),
        );
      },
    );
  }
}
