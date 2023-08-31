import 'package:app/core/utils/drawer_utils.dart';
import 'package:flutter/material.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({
    super.key,
    this.isRightDrawer = false,
  });

  final bool isRightDrawer;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return InkWell(
      onTap: isRightDrawer ? DrawerUtils.openEndDrawer : DrawerUtils.openDrawer,
      child: Icon(
        Icons.menu_rounded,
        color: onSurface,
      ),
    );
  }
}
