import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Assets.icons.icEmptyList.svg(),
          SizedBox(height: Spacing.smMedium),
          Text(
            emptyText ?? t.common.defaultEmptyList,
            style: Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
