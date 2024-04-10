import 'dart:math';

import 'package:flutter/material.dart';
import 'package:web3modal_flutter/theme/constants.dart';
import 'package:web3modal_flutter/theme/w3m_theme.dart';

class BaseGridItem extends StatelessWidget {
  const BaseGridItem({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.child,
  });
  final VoidCallback? onTap;
  final bool isSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final themeColors = Web3ModalTheme.colorsOf(context);
    final radiuses = Web3ModalTheme.radiusesOf(context);
    final maxRadius = min(radiuses.radiusXS, 32.0);
    return FilledButton(
      onPressed: onTap,
      clipBehavior: Clip.antiAlias,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(
          const Size(kGridItemWidth, kGridItemHeight),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          isSelected ? themeColors.accenGlass020 : themeColors.grayGlass002,
        ),
        overlayColor: MaterialStateProperty.all<Color>(
          isSelected ? themeColors.accenGlass020 : themeColors.grayGlass005,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(maxRadius),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(0.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: child,
      ),
    );
  }
}
