import 'package:app/core/presentation/widgets/common/photos_gallery_carousel/photos_gallery_carousel.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class CollaboratorDiscoverPhotosCard extends StatelessWidget {
  const CollaboratorDiscoverPhotosCard({
    super.key,
    required this.photos,
  });
  final List<String> photos;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: LemonColor.white06,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LemonRadius.normal),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoGalleryCarousel(
              photos: photos,
            ),
            Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Turning stress into art. Metaverse much? Learning something new everyday!',
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
