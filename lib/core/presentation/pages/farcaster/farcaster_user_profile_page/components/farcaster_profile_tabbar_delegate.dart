import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class _ProfileTabBar extends StatefulWidget {
  final TabController controller;
  const _ProfileTabBar({
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
      if (widget.controller.indexIsChanging) return;
      setState(() {
        currentIndex = widget.controller.index;
      });
    });
    super.initState();
  }

  List<String> getTabs() {
    final t = Translations.of(context);
    return [
      t.farcaster.profile.profileTabs.casts,
      t.farcaster.profile.profileTabs.replies,
      t.farcaster.profile.profileTabs.likes,
    ];
  }

  List<Widget> _renderTabs(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return getTabs().asMap().entries.map((item) {
      var isSelected = item.key == currentIndex;
      return Tab(
        child: SizedBox(
          child: Text(
            item.value,
            style: Typo.medium.copyWith(
              color: !isSelected
                  ? colorScheme.onSurfaceVariant
                  : colorScheme.onPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
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
          indicatorColor: LemonColor.paleViolet,
        ),
      ),
    );
  }
}

class FarcasterProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController controller;
  FarcasterProfileTabBarDelegate({
    required this.controller,
  });

  @override
  Widget build(BuildContext context, shrinkOffset, overlapsContent) {
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
