import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NotificationThumbnail extends StatelessWidget {
  final String imageUrl;
  final Function()? onTap;
  final BorderRadius? radius;
  final Widget? placeholder;

  const NotificationThumbnail({
    super.key,
    this.onTap,
    required this.imageUrl,
    this.radius,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mRadius = radius ?? BorderRadius.circular(LemonRadius.extraSmall);
    final mPlaceholder = placeholder ??
        ImagePlaceholder.defaultPlaceholder(
          radius: mRadius,
        );
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: mRadius,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outline),
            borderRadius: mRadius,
          ),
          width: Sizing.medium,
          height: Sizing.medium,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            placeholder: (_, __) => mPlaceholder,
            errorWidget: (_, __, ___) => mPlaceholder,
          ),
        ),
      ),
    );
  }
}
