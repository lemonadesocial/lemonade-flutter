import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class ImagePlaceholder {
  static Widget eventCard() {
    return Container(
      height: 200,
      width: double.infinity,
      child: Center(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icLemonOutline.svg(colorFilter: filter, width: 50, height: 50),
        ),
      ),
    );
  }

  static Widget defaultPlaceholder() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Center(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icLemonOutline.svg(colorFilter: filter, width: 50, height: 50),
        ),
      ),
    );
  }
}
