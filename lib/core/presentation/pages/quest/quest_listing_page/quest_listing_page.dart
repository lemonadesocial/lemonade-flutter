import 'package:app/core/application/quest/get_point_groups_bloc/get_point_groups_bloc.dart';
import 'package:app/core/presentation/pages/quest/quest_listing_page/widgets/quest_tab_bar_view_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum QuestListingTabs {
  profile(tabIndex: 0),
  post(tabIndex: 1),
  event(tabIndex: 2),
  citizenship(tabIndex: 3);

  const QuestListingTabs({
    required this.tabIndex,
  });

  final int tabIndex;
}

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
  late int selectedTabIndex = QuestListingTabs.profile.index;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TabBar(
                    onTap: (index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                    labelStyle: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: Typo.medium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorColor: LemonColor.paleViolet,
                    tabs: tabs,
                  ),
                  Expanded(
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
