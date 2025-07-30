import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/app_theme/app_theme.dart';

extension CustomTransitionBuilder on TransitionsBuilders {
  static Widget slideLeft(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final appColors = context.theme.appColors;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        color: animation.value > 0 ? appColors.pageOverlayPrimary : null,
        child: child,
      ),
    );
  }
}
