import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class ImagePlaceholder {
  static Widget eventCard() {
    return Container(
      width: double.infinity,
      height: 200,
      clipBehavior: Clip.none,
      color: const Color.fromRGBO(90, 55, 131, 0.8),
      child: ImageFiltered(
        imageFilter: const ColorFilter.mode(
          Color.fromRGBO(90, 55, 131, 0.5),
          BlendMode.srcIn,
        ),
        child: Image(
          fit: BoxFit.cover,
          image: Assets.images.bgChat.provider(),
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
