import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:flutter/material.dart';

class _ProfileTabBar extends StatefulWidget {
  final TabController controller;
  _ProfileTabBar({
    required this.controller,
  });

  @override
  State<_ProfileTabBar> createState() => _ProfileTabBarState();
}

class _ProfileTabBarState extends State<_ProfileTabBar> {
  int currentIndex = 0;

  @override
  initState() {
    widget.controller.addListener(() {
      if(widget.controller.indexIsChanging) return;
      setState(() {
        currentIndex = widget.controller.index;
      });
    });
    super.initState();
  }

  List<SvgGenImage> get _tabIcons => [
        Assets.icons.icNews,
        Assets.icons.icCrystal,
        Assets.icons.icHouseParty,
        Assets.icons.icCamera,
        // Assets.icons.icStore,
        Assets.icons.icInfo,
      ];

  List<Widget> _renderTabs(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return _tabIcons.asMap().entries.map((item) {
      var isSelected = item.key == currentIndex;
      var svgIcon = item.value;
      return Tab(
        child: SizedBox(
          child: ThemeSvgIcon(
            color: !isSelected ? colorScheme.onSurfaceVariant : colorScheme.onPrimary,
            builder: (filter) => svgIcon.svg(colorFilter: filter),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Builder(
      builder: (context) => Container(
        color: colorScheme.primary,
        height: 48,
        child: TabBar(
          controller: widget.controller,
          tabs: _renderTabs(context),
          indicatorColor: LemonColor.lavender,
        ),
      ),
    );
  }
}

class ProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController controller;
  ProfileTabBarDelegate({
    required this.controller,
  });

  @override
  Widget build(BuildContext context, _, __) {
    return _ProfileTabBar(controller: controller);
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
