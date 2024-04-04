import 'package:app/core/presentation/widgets/common/appbar/appbar_logo.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LemonCircleAvatar extends StatelessWidget {
  final String? url;
  final double? size;
  final String? label;
  final bool? isLemonIcon;
  final double? lemonIconScale;
  const LemonCircleAvatar({
    super.key,
    this.url,
    this.size,
    this.label,
    this.isLemonIcon,
    this.lemonIconScale,
  });

  double get avatarSize => size ?? Sizing.regular;

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    return label == null
        ? _buildAvatar(themeColor)
        : Row(
            children: [
              _buildAvatar(themeColor),
              SizedBox(width: Spacing.xSmall),
              Flexible(
                child: Text(label!),
              ),
            ],
          );
  }

  Container _buildAvatar(ColorScheme themeColor) {
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(avatarSize),
        border: Border.all(color: themeColor.outline),
        color: LemonColor.otherMessage,
      ),
      child: isLemonIcon == true
          ? AppBarLogo(scale: lemonIconScale)
          : ClipRRect(
              borderRadius: BorderRadius.circular(avatarSize),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: url ?? '',
                placeholder: (ctx, url) => _buildPlaceHolder(),
                errorWidget: (ctx, url, error) => _buildPlaceHolder(),
              ),
            ),
    );
  }

  Widget _buildPlaceHolder() => Center(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icLemonOutline
              .svg(colorFilter: filter, width: 18, height: 18),
        ),
      );
}
