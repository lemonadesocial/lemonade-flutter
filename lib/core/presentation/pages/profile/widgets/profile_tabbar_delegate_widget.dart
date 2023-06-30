import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';

class _ProfileTabBar extends StatelessWidget {
  List<Widget> get tabs {
    return [
      Tab(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icGrid.svg(colorFilter: filter),
        ),
      ),
      Tab(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icCrystal.svg(colorFilter: filter),
        ),
      ),
      Tab(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icHouseParty.svg(colorFilter: filter),
        ),
      ),
      Tab(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icCamera.svg(colorFilter: filter),
        ),
      ),
      Tab(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icStore.svg(colorFilter: filter),
        ),
      ),
      Tab(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icInfo.svg(colorFilter: filter),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: colorScheme.primary,
      height: 48,
      child: TabBar(
        tabs: tabs,
        indicatorColor: LemonColor.lavender,
      ),
    );
  }
}

class ProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, _, __) {
    return _ProfileTabBar();
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
