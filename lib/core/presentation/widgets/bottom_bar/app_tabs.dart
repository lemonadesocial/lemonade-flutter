import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppTab {
  home,
  discover,
  notification,
  chat,
}

class TabData {
  TabData(this.tab, this.route, this.icon, this.selectedIcon);
  final AppTab tab;
  final String route;
  final Widget icon;
  final Widget selectedIcon;
}

final List<TabData> tabs = [
  TabData(
    AppTab.home,
    '/home',
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icHouse.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icoHouseFilled.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
  TabData(
    AppTab.discover,
    '/discover',
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icDiscover.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icDiscoverFilled.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
  TabData(
    AppTab.notification,
    '/notification',
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icNotification.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icNotificationFilled.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
  TabData(
    AppTab.chat,
    '/chat',
    ThemeSvgIcon(
      color: LemonColor.white54,
      builder: (filter) => Assets.icons.icChatBubble.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
    ThemeSvgIcon(
      color: LemonColor.white87,
      builder: (filter) => Assets.icons.icChatBubbleFilled.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
];
