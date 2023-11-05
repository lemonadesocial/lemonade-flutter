import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String? emptyText;
  const EmptyList({
    super.key,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.icEmptyList.svg(),
          if (emptyText != null) ...[
            SizedBox(height: Spacing.smMedium),
            Text(
              emptyText!,
              style: Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}
