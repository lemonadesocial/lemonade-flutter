
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AppTab {
  home,
  events,
  notification,
  wallet,
  profile,
}

class TabData {
  TabData(this.tab, this.route, this.icon);
  final AppTab tab;
  final String route;
  final Widget icon;
}

final List<TabData> tabs = [
  TabData(
    AppTab.home,
    '/',
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icHouse.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
  TabData(
    AppTab.events,
    '/events',
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icHouseParty.svg(
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
      builder: (filter) => Assets.icons.icInbox.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
  TabData(
    AppTab.wallet,
    '/wallet',
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icWallet.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
  TabData(
    AppTab.profile,
    '/me',
    ThemeSvgIcon(
      builder: (filter) => Assets.icons.icHouse.svg(
        colorFilter: filter,
        width: 24.w,
        height: 24.w,
      ),
    ),
  ),
];