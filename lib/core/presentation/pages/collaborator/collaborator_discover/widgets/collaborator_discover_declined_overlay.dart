import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorDiscoverDeclinedOverlay extends StatelessWidget {
  const CollaboratorDiscoverDeclinedOverlay({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: Colors.black.withOpacity(0.8),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          width: 96.w,
          height: 96.w,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(LemonRadius.large * 2),
            ),
          ),
          child: Center(
            child: ThemeSvgIcon(
              color: LemonColor.coralReef,
              builder: (filter) => Assets.icons.icClose.svg(
                width: 40.w,
                height: 40.w,
                colorFilter: filter,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
