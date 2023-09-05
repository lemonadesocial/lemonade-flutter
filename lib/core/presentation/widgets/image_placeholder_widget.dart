import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePlaceholder {
  static Widget eventCard() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icLemonOutline
              .svg(colorFilter: filter, width: 50, height: 50),
        ),
      ),
    );
  }

  static Widget defaultPlaceholder({BorderRadius? radius}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: radius ?? BorderRadius.circular(LemonRadius.small),
      ),
      child: Center(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icLemonOutline
              .svg(colorFilter: filter, width: 50, height: 50),
        ),
      ),
    );
  }
}
