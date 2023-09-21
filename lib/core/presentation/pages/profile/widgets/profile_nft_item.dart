import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/media_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileNftItem extends StatelessWidget {
  final List<Media> mediaList;
  final int index;

  const ProfileNftItem({
    super.key,
    required this.mediaList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => context.router.push(
        PhotosGalleryRoute(
          initialIndex: index,
          photos: mediaList
              .where((e) => e.type == MediaType.image && e.url != null)
              .map((e) => e.url!)
              .toList(),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: colorScheme.outline),
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
          child: CachedNetworkImage(
            imageUrl: mediaList[index].url ?? '',
            fit: BoxFit.cover,
            errorWidget: (ctx, _, __) => ImagePlaceholder.defaultPlaceholder(),
            placeholder: (ctx, _) => ImagePlaceholder.defaultPlaceholder(),
          ),
        ),
      ),
    );
  }
}
