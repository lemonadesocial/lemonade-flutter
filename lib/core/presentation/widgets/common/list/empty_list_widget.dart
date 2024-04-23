import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum EmptyListSize {
  small,
  large,
}

class EmptyList extends StatelessWidget {
  final String? emptyText;
  final EmptyListSize size;

  const EmptyList({
    super.key,
    this.emptyText,
    this.size = EmptyListSize.large,
  });

  Size? get iconSize {
    if (size == EmptyListSize.small) {
      return Size(84.w, 84.w);
    }
    return null;
  }

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
            style: Typo.small.copyWith(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
