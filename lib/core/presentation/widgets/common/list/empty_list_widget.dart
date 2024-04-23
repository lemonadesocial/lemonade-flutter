import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String? emptyText;
  final Size? iconSize;
  final TextStyle? textStyle;
  const EmptyList({
    super.key,
    this.emptyText,
    this.iconSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Assets.icons.icEmptyList.svg(
            width: iconSize?.width,
            height: iconSize?.height,
          ),
          SizedBox(height: Spacing.smMedium),
          Text(
            emptyText ?? t.common.defaultEmptyList,
            style: textStyle ??
                Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
