import 'package:app/core/presentation/pages/left_panel/left_panel_page.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerItem {
  DrawerItem({
    required this.icon,
    required this.label,
    this.onPressed,
    this.featureAvailable = true,
  });

  final SvgGenImage icon;
  final String label;
  final Function()? onPressed;
  final bool featureAvailable;
}

class LemonDrawer extends StatelessWidget {
  const LemonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Drawer(
        width: MediaQuery.of(context).size.width,
        backgroundColor: colorScheme.primary,
        child: const LeftPanelPage(),
      ),
    );
  }
}
