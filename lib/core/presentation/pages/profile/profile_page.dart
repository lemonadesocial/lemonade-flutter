import 'package:app/core/presentation/guard/auth_guard.dart';
import 'package:app/core/presentation/pages/auth/login_page.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_page_header_widget.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_tabbar_delegate_widget.dart';
import 'package:app/core/presentation/pages/profile/widgets/tabs/empty_tab_view.dart';
import 'package:app/core/presentation/pages/profile/widgets/tabs/profile_collectible_tab_view.dart';
import 'package:app/core/presentation/pages/profile/widgets/tabs/profile_event_tab_view.dart';
import 'package:app/core/presentation/pages/profile/widgets/tabs/profile_info_tab_view.dart';
import 'package:app/core/presentation/pages/profile/widgets/tabs/profile_photos_tab_view.dart';
import 'package:app/core/presentation/widgets/burger_menu_widget.dart';
import 'package:app/core/presentation/widgets/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthGuard(
      unauthenticatedBuilder: (context) => const LoginPage(),
      authenticatedBuilder: (context) => const ProfilePageView(),
    );
  }
}

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> with SingleTickerProviderStateMixin {
  double get _headerHeight => 230;

  int get _tabCount => 6;

  late final TabController _tabCtrl = TabController(
    length: _tabCount,
    vsync: this,
    initialIndex: 0,
  );

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: _appBar(colorScheme),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            expandedHeight: _headerHeight,
            collapsedHeight: _headerHeight,
            flexibleSpace: ProfilePageHeader(),
            forceElevated: innerBoxIsScrolled,
          ),
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: ProfileTabBarDelegate(controller: _tabCtrl),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabCtrl,
          children: [
            EmptyTabView(),
            ProfileCollectibleTabView(),
            ProfileEventTabView(),
            ProfilePhotosTabView(),
            EmptyTabView(),
            ProfileInfoTabView(),
          ],
        ),
      ),
    );
  }

  LemonAppBar _appBar(ColorScheme colorScheme) {
    return LemonAppBar(
      title: '@coop.er',
      leading: BurgerMenu(),
      actions: [
        ThemeSvgIcon(
          color: colorScheme.onSurface,
          builder: (filter) => Assets.icons.icShare.svg(colorFilter: filter),
        ),
        ThemeSvgIcon(
          color: colorScheme.onSurface,
          builder: (filter) => Assets.icons.icMoreHoriz.svg(colorFilter: filter),
        ),
      ],
    );
  }
}
