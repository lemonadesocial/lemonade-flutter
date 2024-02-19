import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    Key? key,
    this.strength = 1,
    this.child,
  }) : super(key: key);

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
