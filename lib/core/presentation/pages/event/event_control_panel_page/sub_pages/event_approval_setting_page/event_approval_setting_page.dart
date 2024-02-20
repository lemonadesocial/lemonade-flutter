import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/view/event_accepted_export_list.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/view/event_join_requests_list.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_item/event_confirmed_join_request_item.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_item/event_pending_join_request_item.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/widgets/join_request_item/event_rejected_join_request_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventApprovalSettingPage extends StatefulWidget {
  const EventApprovalSettingPage({super.key});

  @override
  State<EventApprovalSettingPage> createState() =>
      _EventApprovalSettingPageState();
}

class JoinRequestTabItem {
  final String title;
  final SvgGenImage icon;
  final Color activeColor;
  final Color inactiveColor;

  const JoinRequestTabItem({
    required this.title,
    required this.icon,
    required this.activeColor,
    required this.inactiveColor,
  });
}

class _EventApprovalSettingPageState extends State<EventApprovalSettingPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int activeIndex = 0;
  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (activeIndex != _tabController.index) {
        setState(() {
          activeIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    final approvalRequired = event?.approvalRequired ?? false;
    final tabItems = [
      JoinRequestTabItem(
        title: t.event.eventApproval.tabs.pending,
        icon: Assets.icons.icInfo,
        activeColor: LemonColor.errorRedBg,
        inactiveColor: colorScheme.onSecondary,
      ),
      JoinRequestTabItem(
        title: t.event.eventApproval.tabs.reservations,
        icon: Assets.icons.icDone,
        activeColor: LemonColor.paleViolet,
        inactiveColor: colorScheme.onSecondary,
      ),
      JoinRequestTabItem(
        title: t.event.eventApproval.tabs.rejected,
        icon: Assets.icons.icClose,
        activeColor: LemonColor.errorRedBg,
        inactiveColor: colorScheme.onSecondary,
      ),
    ];

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: t.event.eventApproval.guests,
      ),
      body: SafeArea(
        child: !approvalRequired
            ? SizedBox(
                child: EventAcceptedExportList(
                  event: event,
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: Sizing.medium,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                      itemCount: tabItems.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: Spacing.extraSmall),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final tabItem = tabItems[index];
                        return _CustomTab(
                          colorScheme: colorScheme,
                          tabItem: tabItem,
                          onPress: () => _tabController.animateTo(index),
                          isActive: activeIndex == index,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        EventJoinRequestList(
                          state: Enum$JoinRequestState.pending,
                          event: event,
                          itemBuilder: ({
                            required eventJoinRequest,
                            refresh,
                          }) =>
                              EventPendingJoinRequestItem(
                            eventJoinRequest: eventJoinRequest,
                            onRefetch: refresh,
                          ),
                        ),
                        EventJoinRequestList(
                          state: Enum$JoinRequestState.approved,
                          event: event,
                          itemBuilder: ({
                            required eventJoinRequest,
                            refresh,
                          }) =>
                              EventConfirmedJoinRequestItem(
                            eventJoinRequest: eventJoinRequest,
                          ),
                        ),
                        EventJoinRequestList(
                          state: Enum$JoinRequestState.declined,
                          event: event,
                          itemBuilder: ({
                            required eventJoinRequest,
                            refresh,
                          }) =>
                              EventRejectedJoinRequestItem(
                            eventJoinRequest: eventJoinRequest,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _CustomTab extends StatelessWidget {
  const _CustomTab({
    required this.colorScheme,
    required this.tabItem,
    required this.onPress,
    this.isActive = false,
  });

  final ColorScheme colorScheme;
  final JoinRequestTabItem tabItem;
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
