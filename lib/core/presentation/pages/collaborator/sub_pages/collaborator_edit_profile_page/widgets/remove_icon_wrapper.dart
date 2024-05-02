import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class RemoveIconWrapper extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const RemoveIconWrapper({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -Spacing.superExtraSmall,
          right: -Spacing.superExtraSmall,
          child: _RemoveIcon(
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}

class _RemoveIcon extends StatelessWidget {
  final Function()? onTap;
  const _RemoveIcon({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizing.regular,
        height: Sizing.regular,
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline),
          color: colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Assets.icons.icClose.svg(),
        ),
      ),
    );
  }
}
