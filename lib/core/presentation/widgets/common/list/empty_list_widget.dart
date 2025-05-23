import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Assets.icons.icEmptyList.svg(
            width: iconSize?.width,
            height: iconSize?.height,
          ),
          SizedBox(height: Spacing.s4),
          Text(
            emptyText ?? t.common.defaultEmptyList,
            style: appText.sm.copyWith(
              color: appColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
