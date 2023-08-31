import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LemonCircleAvatar extends StatelessWidget {
  const LemonCircleAvatar({
    super.key,
    required this.url,
    this.size,
    this.label,
  });
  final String url;
  final double? size;
  final String? label;

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
              Text(label!),
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
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(avatarSize),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: url,
            placeholder: (ctx, url) => _buildPlaceHolder(),
            errorWidget: (ctx, url, error) => _buildPlaceHolder(),
          ),
        ),);
  }

  Widget _buildPlaceHolder() => Center(
        child: ThemeSvgIcon(
          builder: (filter) => Assets.icons.icLemonOutline.svg(colorFilter: filter, width: 18, height: 18),
        ),
      );
}
