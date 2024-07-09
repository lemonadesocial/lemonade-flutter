import 'package:app/core/presentation/pages/quest/widgets/quest_item_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

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

class QuestListingPageView extends StatefulWidget {
  const QuestListingPageView({
    super.key,
  });

  @override
  State<QuestListingPageView> createState() => _QuestListingPageViewState();
}

class _QuestListingPageViewState extends State<QuestListingPageView>
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
            TabBar(
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
              tabs: [
                Tab(text: StringUtils.capitalize(t.quest.questsTabs.profile)),
                Tab(text: StringUtils.capitalize(t.quest.questsTabs.post)),
                Tab(text: StringUtils.capitalize(t.quest.questsTabs.events)),
                Tab(
                  text: StringUtils.capitalize(t.quest.questsTabs.citizenship),
                ),
              ],
            ),
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
