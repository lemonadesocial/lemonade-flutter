import 'package:app/app_theme/app_theme.dart';
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
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizing.regular,
        height: Sizing.regular,
        decoration: BoxDecoration(
          border: Border.all(color: appColors.pageDivider),
          color: appColors.cardBg,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Assets.icons.icClose.svg(),
        ),
      ),
    );
  }
}
