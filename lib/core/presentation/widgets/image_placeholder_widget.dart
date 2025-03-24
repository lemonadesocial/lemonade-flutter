import 'dart:math';

import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/avatar_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class ImagePlaceholder {
  static Widget eventCard() {
    return Image(
      fit: BoxFit.cover,
      image: Assets.images.bgNoPhotoEvent.provider(),
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

  static Widget avatarPlaceholder({BorderRadius? radius}) {
    final randomId = Random().nextInt(100);
    return LemonCircleAvatar(
      size: Sizing.medium,
      url: AvatarUtils.randomUserImage(randomId.toString()),
    );
  }

  static Widget ticketThumbnail({
    Color? iconColor,
    Color? backgroundColor,
    double? iconSize,
  }) {
    return Container(
      height: Sizing.medium,
      width: Sizing.medium,
      decoration: BoxDecoration(
        color: backgroundColor ?? LemonColor.atomicBlack,
      ),
      child: Center(
        child: ThemeSvgIcon(
          color: iconColor,
          builder: (filter) => Assets.icons.icTicket.svg(
            height: iconSize ?? Sizing.xSmall,
            width: iconSize ?? Sizing.xSmall,
            colorFilter: filter,
          ),
        ),
      ),
    );
  }

  static Widget spaceThumbnail({
    double? iconSize,
    BorderRadius? radius,
    Color? backgroundColor,
    Color? iconColor,
    EdgeInsets? padding,
  }) {
    return Container(
      height: Sizing.medium,
      width: Sizing.medium,
      decoration: BoxDecoration(
        color: backgroundColor ?? LemonColor.chineseBlack,
        borderRadius: radius ?? BorderRadius.circular(LemonRadius.extraSmall),
      ),
      padding: padding,
      child: Center(
        child: ThemeSvgIcon(
          color: iconColor,
          builder: (filter) => Assets.icons.icWorkspace.svg(
            colorFilter: filter,
          ),
        ),
      ),
    );
  }
}
