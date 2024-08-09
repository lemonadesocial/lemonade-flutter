import 'package:app/core/application/quest/get_point_groups_bloc/get_point_groups_bloc.dart';
import 'package:app/core/domain/quest/entities/point_group.dart';
import 'package:app/core/domain/quest/entities/quest_group.dart';
import 'package:app/core/presentation/pages/quest/quest_listing_page/widgets/quest_completed_card.dart';
import 'package:app/core/presentation/pages/quest/quest_listing_page/widgets/quest_list.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestTabBarViewItem extends StatelessWidget {
  const QuestTabBarViewItem({
    super.key,
    required this.pointGroup,
    required this.secondaryLevelGroups,
  });

  final PointGroup pointGroup;
  final List<QuestGroup>? secondaryLevelGroups;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if ((pointGroup.points ?? 0) > 0)
          SliverPadding(
            padding: EdgeInsets.only(
              top: Spacing.xSmall,
              left: Spacing.xSmall,
              right: Spacing.xSmall,
            ),
            sliver: SliverToBoxAdapter(
              child: QuestCompletedCard(
                completedCount: pointGroup.completed ?? 0,
                pointsCount: pointGroup.points ?? 0,
                typeTitle: pointGroup.firstLevelGroup?.title ?? '',
                onTap: () {
                  AutoRouter.of(context)
                      .navigate(const CompletedQuestsListingRoute());
                },
              ),
            ),
          ),
        SliverToBoxAdapter(
          child: _SecondaryLevelGroup(
            secondaryLevelGroups: secondaryLevelGroups,
            onTap: (secondaryLevelGroupId) {
              context.read<GetPointGroupsBloc>().add(
                    GetPointGroupsEvent.selectSecondLevelGroup(
                      secondLevelGroup: secondaryLevelGroupId,
                    ),
                  );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Spacing.medium,
          ),
        ),
        const QuestList(),
      ],
    );
  }
}

class _SecondaryLevelGroup extends StatelessWidget {
  const _SecondaryLevelGroup({
    required this.secondaryLevelGroups,
    required this.onTap,
  });

  final List<QuestGroup>? secondaryLevelGroups;
  final Function(String? secondaryLevelGroupId)? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (secondaryLevelGroups != null) {
      if (secondaryLevelGroups!.isEmpty) {
        return const SizedBox.shrink();
      }
    }
    return BlocBuilder<GetPointGroupsBloc, GetPointGroupsState>(
      builder: (context, state) {
        final selectedSecondaryLevelGroup = state.selectedSecondLevelGroup;
        return Padding(
          padding: EdgeInsets.only(
            top: Spacing.small,
            left: Spacing.small,
            right: Spacing.small,
          ),
          child: SizedBox(
            height: Sizing.medium,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  SizedBox(width: Spacing.extraSmall),
              itemCount: secondaryLevelGroups?.length ?? 0,
              itemBuilder: (context, index) {
                final secondaryLevelGroup = secondaryLevelGroups?[index];
                final secondaryLevelGroupId = secondaryLevelGroup?.id ?? '';
                final selected =
                    secondaryLevelGroupId == selectedSecondaryLevelGroup;
                return LemonOutlineButton(
                  onTap: () {
                    if (onTap != null) {
                      onTap!.call(secondaryLevelGroupId);
                    }
                  },
                  textColor: selected == true
                      ? colorScheme.onPrimary
                      : colorScheme.onSecondary,
                  backgroundColor: Colors.transparent,
                  borderColor: selected == true
                      ? colorScheme.onPrimary
                      : colorScheme.outline,
                  label: StringUtils.capitalize(secondaryLevelGroup?.title),
                  radius: BorderRadius.circular(LemonRadius.button),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
