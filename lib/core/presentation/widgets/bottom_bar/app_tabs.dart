import 'package:app/gen/assets.gen.dart';

enum AppTab {
  home,
  spaces,
  discover,
  chat,
  // notification,
}

class TabData {
  TabData(this.tab, this.route, this.icon, this.selectedIcon);
  final AppTab tab;
  final String route;
  final SvgGenImage icon;
  final SvgGenImage selectedIcon;
}

final List<TabData> tabs = [
  TabData(
    AppTab.home,
    '/home',
    Assets.icons.icHouse,
    Assets.icons.icoHouseFilled,
  ),
  TabData(
    AppTab.spaces,
    '/home-spaces',
    Assets.icons.icWorkspacesOutline,
    Assets.icons.icWorkspacesFilled,
  ),
  TabData(
    AppTab.discover,
    '/discover',
    Assets.icons.icDiscover,
    Assets.icons.icDiscoverFilled,
  ),
  TabData(
    AppTab.chat,
    '/chat',
    Assets.icons.icChatBubbleOutlineSharp,
    Assets.icons.icChatBubbleOutlineSharpFilled,
  ),
  // TabData(
  //   AppTab.notification,
  //   '/notification',
  //   Assets.icons.icNotification,
  //   Assets.icons.icNotificationSharpFilled,
  // ),
];
