import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoverPhotoItem extends StatelessWidget {
  final DbFile? photo;
  const CoverPhotoItem({
    super.key,
    this.photo,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 200.w,
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Builder(
        builder: (context) {
          if (photo != null) {
            return Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: ImageUtils.generateUrl(file: photo),
                      placeholder: (_, __) =>
                          ImagePlaceholder.defaultPlaceholder(),
                      errorWidget: (_, __, ___) =>
                          ImagePlaceholder.defaultPlaceholder(),
                    ),
                  ),
                ),
                Positioned(
                  top: Spacing.xSmall,
                  right: Spacing.xSmall,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Spacing.superExtraSmall,
                      horizontal: Spacing.xSmall,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.background.withOpacity(0.7),
                      borderRadius:
                          BorderRadius.circular(LemonRadius.extraSmall),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: Text(
                      t.event.eventPhotos.editCover,
                      style: Typo.small.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (colorFilter) => Assets.icons.icAddPhoto.svg(
                    colorFilter: colorFilter,
                  ),
                ),
                SizedBox(height: Spacing.xSmall),
                Text(
                  t.event.eventPhotos.uploadHint,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
