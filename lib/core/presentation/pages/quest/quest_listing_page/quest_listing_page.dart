import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/quest/get_point_groups_bloc/get_point_groups_bloc.dart';
import 'package:app/core/domain/quest/entities/point_group.dart';
import 'package:app/core/presentation/pages/quest/quest_listing_page/widgets/quest_tab_bar_view_item.dart';
import 'package:app/core/presentation/pages/quest/quest_listing_page/widgets/quest_total_point_banner.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class QuestListingPage extends StatefulWidget {
  const QuestListingPage({
    super.key,
  });

  @override
  State<QuestListingPage> createState() => _QuestListingPageState();
}

class _QuestListingPageState extends State<QuestListingPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final user = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    return Scaffold(
      appBar: LemonAppBar(
        title: t.quest.quests,
      ),
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: BlocBuilder<GetPointGroupsBloc, GetPointGroupsState>(
          builder: (context, state) {
            final fetching = state.fetching;
            final pointGroups = state.pointGroups;
            List<String?> pointGroupsTitle =
                pointGroups.map((item) => item.firstLevelGroup?.title).toList();
            List<Tab> tabs = pointGroupsTitle.map((tabName) {
              return Tab(text: StringUtils.capitalize(tabName));
            }).toList();

            if (fetching) {
              return Center(
                child: Loading.defaultLoading(context),
              );
            }
            return DefaultTabController(
              length: tabs.length,
              initialIndex: 0,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                      child: QuestTotalPointBanner(
                        totalPoint: user?.questPoints ?? 0,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: Spacing.smMedium)),
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: _Tabbar(
                      onTap: (index) {
                        context.read<GetPointGroupsBloc>().add(
                              GetPointGroupsEvent.selectFirstLevelGroup(
                                firstLevelGroup:
                                    pointGroups[index].firstLevelGroup?.id,
                              ),
                            );
                      },
                      pointGroups: pointGroups,
                      tabs: tabs,
                    ),
                  ),
                ],
                body: BlocListener<GetPointGroupsBloc, GetPointGroupsState>(
                  listener: (context, state) async {
                    if (state.selectedFirstLevelGroup != null) {
                      final indexOfTab = state.pointGroups.indexWhere(
                        (element) =>
                            element.firstLevelGroup?.id ==
                            state.selectedFirstLevelGroup,
                      );
                      DefaultTabController.of(context)
                          .animateTo(indexOfTab, duration: Duration.zero);
                    }
                  },
                  child: Expanded(
                    child: TabBarView(
                      children: pointGroups.map((pointGroup) {
                        final secondaryLevelGroups =
                            pointGroup.secondLevelGroups;
                        return QuestTabBarViewItem(
                          pointGroup: pointGroup,
                          secondaryLevelGroups: secondaryLevelGroups,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Tabbar extends SliverPersistentHeaderDelegate {
  const _Tabbar({
    required this.onTap,
    required this.pointGroups,
    required this.tabs,
  });

  final Function(int index) onTap;
  final List<PointGroup> pointGroups;
  final List<Tab> tabs;

  @override
  double get maxExtent => 42.w;

  @override
  double get minExtent => 42.w;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(BuildContext context, shrinkOffset, overlapsContent) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.background,
      child: TabBar(
        onTap: (index) {
          onTap(index);
        },
        labelStyle: Typo.medium.copyWith(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: Typo.medium.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.onPrimary,
              width: 1.w,
            ),
          ),
        ),
        tabs: tabs,
      ),
    );
  }
}
