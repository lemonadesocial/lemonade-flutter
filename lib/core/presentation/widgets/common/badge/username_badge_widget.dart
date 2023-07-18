import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class TextBadge extends StatelessWidget {
  final String label;
  const TextBadge({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.superExtraSmall),
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(LemonRadius.xSmall)),
      ),
      child: Center(
        child: Text(
          label,
          style: Typo.xSmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
