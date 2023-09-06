import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class LemonButton extends StatelessWidget {
  final String label;
  final Widget? icon;
  final Function()? onTap;

  const LemonButton({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: 107,
        height: 42,
        padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LemonRadius.button),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 6),
            ],
            Text(label,
                style: Typo.medium.copyWith(
                    fontWeight: FontWeight.w400, color: colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
