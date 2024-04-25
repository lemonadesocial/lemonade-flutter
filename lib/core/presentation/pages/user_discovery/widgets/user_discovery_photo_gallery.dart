import 'package:app/core/presentation/widgets/common/photos_gallery_view/photo_gallery_view.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class UserDiscoveryPhotoGallery extends StatelessWidget {
  const UserDiscoveryPhotoGallery({
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
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoGalleryView(
              photos: photos,
            ),
            Container(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        'Turning stress into art. Metaverse much? Learning something new everyday!',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
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
