import 'package:flutter/material.dart';

class ThemeSvgIcon extends StatelessWidget {
  const ThemeSvgIcon({
    super.key,
    required this.builder,
    this.color,
  });
  final Function(ColorFilter colorFilter) builder;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    return builder(ColorFilter.mode(color ?? onPrimaryColor, BlendMode.srcIn));
  }
}
