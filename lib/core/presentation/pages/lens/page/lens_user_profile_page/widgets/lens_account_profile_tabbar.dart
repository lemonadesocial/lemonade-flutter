import 'package:flutter/material.dart';
import 'package:app/app_theme/app_theme.dart';

class _LensAccountProfileTabBar extends StatefulWidget {
  final TabController controller;
  const _LensAccountProfileTabBar({
    required this.controller,
  });

  @override
  State<_LensAccountProfileTabBar> createState() =>
      _LensAccountProfileTabBarState();
}

class _LensAccountProfileTabBarState extends State<_LensAccountProfileTabBar> {
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
    return [
      "Feed",
    ];
  }

  List<Widget> _renderTabs(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return getTabs().asMap().entries.map((item) {
      var isSelected = item.key == currentIndex;
      return Tab(
        child: SizedBox(
          child: Text(
            item.value,
            style: appText.md.copyWith(
              color:
                  !isSelected ? appColors.textTertiary : appColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return Builder(
      builder: (context) => SizedBox(
        height: 48,
        child: TabBar(
          controller: widget.controller,
          tabs: _renderTabs(context),
          indicatorColor: appColors.textAccent,
        ),
      ),
    );
  }
}

class LensAccountProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController controller;
  LensAccountProfileTabBarDelegate({
    required this.controller,
  });

  @override
  Widget build(BuildContext context, shrinkOffset, overlapsContent) {
    return _LensAccountProfileTabBar(controller: controller);
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
