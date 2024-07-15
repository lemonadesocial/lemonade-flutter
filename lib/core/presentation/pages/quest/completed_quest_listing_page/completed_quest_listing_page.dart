import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/quest/get_point_groups_bloc/get_point_groups_bloc.dart';
import 'package:app/core/domain/quest/entities/point_config_info.dart';
import 'package:app/core/domain/quest/entities/quest_group.dart';
import 'package:app/core/domain/quest/quest_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/quest/completed_quest_listing_page/widgets/completed_quest_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CompletedQuestsListingPage extends StatelessWidget {
  const CompletedQuestsListingPage({super.key});

  Future<Either<Failure, List<PointConfigInfo>>> getMyPoints({
    required String? firstLevelGroup,
    required String? secondLevelGroup,
  }) async {
    return getIt<QuestRepository>().getMyPoints(
      firstLevelGroup: firstLevelGroup,
      secondLevelGroup: secondLevelGroup,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final loggedInUser = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    final questPoints = loggedInUser?.questPoints;
    return Scaffold(
      backgroundColor: LemonColor.atomicBlack,
      body: BlocBuilder<GetPointGroupsBloc, GetPointGroupsState>(
        builder: (context, state) {
          final pointGroups = state.pointGroups;
          List<QuestGroup?> firstLevelGroups =
              pointGroups.map((item) => item.firstLevelGroup).toList();
          final selectedFirstLevelGroup = state.selectedFirstLevelGroup;
          final selectedSecondaryGroup = state.selectedSecondLevelGroup;
          final selectedPointGroup = state.pointGroups.firstWhere(
            (pointGroup) =>
                pointGroup.firstLevelGroup?.id == selectedFirstLevelGroup,
          );
          final totalQuestsCount = selectedPointGroup.count ?? 0;
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: LemonAppBar(
                  backgroundColor: LemonColor.atomicBlack,
                  actions: [
                    LemonOutlineButton(
                      backgroundColor: LemonColor.chineseBlack,
                      label: t.quest.pointsCount(
                          n: questPoints ?? 0, count: questPoints ?? 0),
                      textStyle: Typo.small.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                      radius: BorderRadius.circular(LemonRadius.button),
                      borderColor: Colors.transparent,
                    ),
                    SizedBox(width: Spacing.smMedium),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.quest.completed,
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontFamily: FontFamily.nohemiVariable,
                        ),
                      ),
                      SizedBox(height: Spacing.superExtraSmall),
                      Text(
                        t.quest.totalQuestsCount(
                          n: totalQuestsCount,
                          count: totalQuestsCount,
                        ),
                        style: Typo.mediumPlus.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.medium,
                  horizontal: Spacing.smMedium,
                ),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: Sizing.medium,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: Spacing.extraSmall),
                      itemCount: firstLevelGroups.length,
                      itemBuilder: (context, index) {
                        final selected = state.selectedFirstLevelGroup ==
                            firstLevelGroups[index]?.id;
                        final title = firstLevelGroups[index]?.title;
                        return LemonOutlineButton(
                          onTap: () {
                            context.read<GetPointGroupsBloc>().add(
                                  GetPointGroupsEvent.selectFirstLevelGroup(
                                    firstLevelGroup:
                                        pointGroups[index].firstLevelGroup?.id,
                                  ),
                                );
                          },
                          textColor: selected == true
                              ? colorScheme.onPrimary
                              : colorScheme.onSecondary,
                          backgroundColor: selected
                              ? LemonColor.chineseBlack
                              : LemonColor.atomicBlack,
                          borderColor:
                              selected ? LemonColor.chineseBlack : null,
                          label: StringUtils.capitalize(title),
                          radius: BorderRadius.circular(LemonRadius.button),
                        );
                      },
                    ),
                  ),
                ),
              ),
              FutureBuilder<List<PointConfigInfo>>(
                future: getMyPoints(
                  firstLevelGroup: selectedFirstLevelGroup,
                  secondLevelGroup: selectedSecondaryGroup,
                ).then(
                  (either) => either.fold(
                    (failure) => [],
                    (myPoints) => myPoints,
                  ),
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SliverToBoxAdapter(
                      child: Loading.defaultLoading(context),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasError) {
                    return const SliverToBoxAdapter(
                      child: EmptyList(),
                    );
                  }
                  List<PointConfigInfo> pointConfigInfos = snapshot.data ?? [];
                  final trackings = pointConfigInfos
                      .expand(
                        (point) => (point.trackings ?? []).map((tracking) {
                          return tracking;
                        }),
                      )
                      .toList();
                  if (trackings.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: EmptyList(),
                    );
                  }
                  return SliverPadding(
                    padding: EdgeInsets.all(Spacing.xSmall),
                    sliver: SliverList.separated(
                      itemCount: trackings.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: Spacing.xSmall),
                      itemBuilder: (context, index) {
                        final pointTrackingInfo = trackings[index];
                        final pointConfigInfo = pointConfigInfos.firstWhere(
                            (item) => item.id == pointTrackingInfo.config);
                        return CompletedQuestItem(
                          title: pointConfigInfo.title,
                          pointTrackingInfo: pointTrackingInfo,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
