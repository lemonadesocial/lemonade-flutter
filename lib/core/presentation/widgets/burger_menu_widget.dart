import 'package:app/core/utils/drawer_utils.dart';
import 'package:flutter/material.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var onSurface = Theme.of(context).colorScheme.onSurface;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        DrawerUtils.openDrawer();
      },
      child: Icon(
        Icons.menu_rounded,
        color: onSurface,
      ),
    );
  }
}
