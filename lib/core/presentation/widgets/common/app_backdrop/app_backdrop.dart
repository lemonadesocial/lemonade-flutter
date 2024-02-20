import 'dart:ui';
import 'package:flutter/material.dart';

class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    super.key,
    this.strength = 1,
    this.child,
  });

  final double strength;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double normalStrength = clampDouble(strength, 0, 1);

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: normalStrength * 10,
        sigmaY: normalStrength * 10,
      ),
      child: child ?? const SizedBox.expand(),
    );
  }
}
