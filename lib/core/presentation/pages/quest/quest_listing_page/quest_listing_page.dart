import 'package:app/core/application/quest/get_point_groups_bloc/get_point_groups_bloc.dart';
import 'package:app/core/presentation/pages/quest/widgets/quest_item_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
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
  late TabController _tabController;
  late int selectedTabIndex = QuestListingTabs.profile.index;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocBuilder<GetPointGroupsBloc, GetPointGroupsState>(
                builder: (context, state) {
              final pointGroups = state.pointGroups;
              List<String?> pointGroupsTitle = pointGroups
                  .map((item) => item.firstLevelGroup?.title)
                  .toList();
              List<Tab> tabs = pointGroupsTitle.map((tabName) {
                return Tab(text: StringUtils.capitalize(tabName));
              }).toList();

              return TabBar(
                onTap: (index) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
                controller: _tabController,
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
              );
            }),
            SizedBox(height: Spacing.extraSmall),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.xSmall,
                      horizontal: Spacing.xSmall,
                    ),
                    child: CustomScrollView(
                      slivers: [
                        _GuestListSection(
                          rooms: const [{}, {}, {}, {}, {}, {}],
                          itemBuilder: () => QuestItemWidget(
                            title: '1 point',
                            subTitle: 'Verify email',
                            onTap: () {},
                            repeatable: true,
                          ),
                          emptyText: t.chat.emptyChannels,
                        ),
                      ],
                    ),
                  ),
                  const CustomScrollView(
                    slivers: [],
                  ),
                  const CustomScrollView(slivers: []),
                  const CustomScrollView(slivers: []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuestListSection extends StatelessWidget {
  const _GuestListSection({
    required this.rooms,
    required this.itemBuilder,
    this.emptyText,
  });

  final List<Object> rooms;
  final Widget Function() itemBuilder;
  final String? emptyText;

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return SliverToBoxAdapter(
        child: EmptyList(emptyText: emptyText),
      );
    }
    return SliverList.separated(
      itemCount: 6,
      itemBuilder: (context, index) => itemBuilder(),
      separatorBuilder: (context, index) => SizedBox(height: Spacing.xSmall),
    );
  }
}
