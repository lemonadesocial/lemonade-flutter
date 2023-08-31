import 'package:flutter/material.dart';

class AppLimitLayoutBuilder extends StatelessWidget {
  const AppLimitLayoutBuilder({
    super.key,
    required this.child,
  });
  final Widget child;

  double get _maxAppWidth => 650;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        constraints: BoxConstraints(maxWidth: _maxAppWidth),
        child: child,
      ),
    );
  }
}
