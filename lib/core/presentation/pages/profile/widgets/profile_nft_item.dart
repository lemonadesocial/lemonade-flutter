import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileNftItem extends StatelessWidget {
  final Media media;

  const ProfileNftItem({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        child: CachedNetworkImage(
          imageUrl: media.url ?? '',
          fit: BoxFit.cover,
          errorWidget: (ctx, _, __) => ImagePlaceholder.defaultPlaceholder(),
          placeholder: (ctx, _) => ImagePlaceholder.defaultPlaceholder(),
        ),
      ),
    );
  }
}
