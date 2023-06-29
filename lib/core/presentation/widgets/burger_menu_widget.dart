import 'package:flutter/material.dart';

class BurgerMenu extends StatelessWidget {
  const BurgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var onSurface = Theme.of(context).colorScheme.onSurface;
    return Icon(Icons.menu_rounded, color: onSurface);
  }
}
