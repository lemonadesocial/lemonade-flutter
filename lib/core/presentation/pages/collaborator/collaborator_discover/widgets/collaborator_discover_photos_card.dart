import 'package:app/core/presentation/widgets/common/photos_gallery_carousel/photos_gallery_carousel.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorDiscoverPhotosCard extends StatelessWidget {
  final String? bio;
  const CollaboratorDiscoverPhotosCard({
    super.key,
    required this.photos,
    this.bio,
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
            if (photos.isEmpty)
              Image(
                height: 315.w,
                fit: BoxFit.cover,
                image: Assets.images.bgNoPhotoEvent.provider(),
              ),
            if (photos.isNotEmpty)
              PhotoGalleryCarousel(
                photos: photos,
              ),
            if (bio != null)
              Container(
                padding: EdgeInsets.all(Spacing.smMedium),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        bio!,
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
