import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/event_dashboard_insight_page.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_rewards_page/event_dashboard_rewards_page.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

@RoutePage()
class EventDashboardPage extends StatefulWidget {
  final String eventId;
  const EventDashboardPage({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDashboardPage> createState() => _EventDashboardPageState();
}

class _EventDashboardPageState extends State<EventDashboardPage>
    with TickerProviderStateMixin {
  late ValueNotifier<GraphQLClient> cubeClient;
  final _listController = AutoScrollController();
  late TabController _tabController;
  int activeIndex = 0;

  @override
  initState() {
    super.initState();
    cubeClient = ValueNotifier(CubeGQL(eventId: widget.eventId).client);
    // TODO: hide revenue so only 2
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (activeIndex != _tabController.index) {
        _listController.scrollToIndex(
          _tabController.index,
          preferPosition: AutoScrollPosition.middle,
        );
        setState(() {
          activeIndex = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final event = context
        .watch<GetEventDetailBloc>()
        .state
        .maybeWhen(orElse: () => null, fetched: (event) => event);
    final t = Translations.of(context);
    final tabItems = [
      _TabItem(
        title: t.event.eventDashboard.insights.insightsTitle,
        icon: Assets.icons.icRoundList,
        activeColor: LemonColor.paleViolet,
        inactiveColor: LemonColor.white54,
      ),
      // TODO: hide revenue
      // _TabItem(
      //   title: t.event.eventDashboard.revenue.revenueTitle,
      //   icon: Assets.icons.icCashVariant,
      //   activeColor: LemonColor.paleViolet,
      //   inactiveColor: LemonColor.white54,
      // ),
      _TabItem(
        title: t.event.eventDashboard.reward.rewardTitle,
        icon: Assets.icons.icReward,
        activeColor: LemonColor.paleViolet,
        inactiveColor: LemonColor.white54,
      ),
    ];
    return GraphQLProvider(
      client: cubeClient,
      child: Scaffold(
        appBar: LemonAppBar(title: t.event.configuration.dashboard),
        body: Column(
          children: [
            SizedBox(
              height: Sizing.medium,
              child: ListView.separated(
                controller: _listController,
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                itemCount: tabItems.length,
                separatorBuilder: (context, index) =>
                    SizedBox(width: Spacing.extraSmall),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final tabItem = tabItems[index];
                  return AutoScrollTag(
                    index: index,
                    controller: _listController,
                    key: ValueKey(index),
                    child: _CustomTab(
                      tabItem: tabItem,
                      onPress: () => _tabController.animateTo(index),
                      isActive: activeIndex == index,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: Spacing.smMedium),
            if (event != null)
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    EventDashboardInsightPage(
                      event: event,
                    ),
                    EventDashboardRewardsPage(event: event),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TabItem {
  final String title;
  final SvgGenImage icon;
  final Color activeColor;
  final Color inactiveColor;

  const _TabItem({
    required this.title,
    required this.icon,
    required this.activeColor,
    required this.inactiveColor,
  });
}

class _CustomTab extends StatelessWidget {
  const _CustomTab({
    required this.tabItem,
    required this.onPress,
    this.isActive = false,
  });

  final _TabItem tabItem;
  final Function() onPress;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => onPress(),
      child: Container(
        height: Sizing.medium,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.small,
          vertical: Spacing.extraSmall,
        ),
        decoration: BoxDecoration(
          color: isActive ? colorScheme.onPrimary.withOpacity(0.09) : null,
          border: Border.all(
            color: isActive ? Colors.transparent : colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(LemonRadius.button),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ThemeSvgIcon(
              color: isActive ? tabItem.activeColor : tabItem.inactiveColor,
              builder: (colorFilter) => tabItem.icon.svg(
                colorFilter: colorFilter,
                width: Sizing.xSmall,
                height: Sizing.xSmall,
              ),
            ),
            SizedBox(width: Spacing.extraSmall),
            Text(
              tabItem.title,
              style: Typo.small.copyWith(
                color:
                    isActive ? colorScheme.onPrimary : colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
