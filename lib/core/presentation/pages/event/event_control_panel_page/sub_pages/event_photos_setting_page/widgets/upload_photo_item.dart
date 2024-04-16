import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum _PhotoActions {
  setCover,
  delete,
}

class UploadPhotoItem extends StatefulWidget {
  final DbFile photo;
  final int index;
  const UploadPhotoItem({
    super.key,
    required this.photo,
    required this.index,
  });

  @override
  State<UploadPhotoItem> createState() => _UploadPhotoItemState();
}

class _UploadPhotoItemState extends State<UploadPhotoItem> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          LemonRadius.medium,
        ),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                LemonRadius.medium,
              ),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: ImageUtils.generateUrl(file: widget.photo),
                placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                errorWidget: (_, __, ___) =>
                    ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
          ),
          Positioned(
            top: Spacing.xSmall,
            left: Spacing.xSmall,
            child: Container(
              width: Sizing.small,
              height: Sizing.small,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              ),
              child: Center(
                child: Text(
                  '${widget.index + 1}',
                  style: Typo.small.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: FontFamily.switzerVariable,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: Spacing.xSmall,
            right: Spacing.xSmall,
            child: FloatingFrostedGlassDropdown<_PhotoActions>(
              containerWidth: 170.w,
              items: [
                DropdownItemDpo(
                  leadingIcon: Assets.icons.icAddPhoto.svg(
                    width: 18.w,
                    height: 18.w,
                  ),
                  label: t.event.eventPhotos.setAsCover,
                  value: _PhotoActions.setCover,
                ),
                DropdownItemDpo(
                  leadingIcon: ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (colorFilter) => Assets.icons.icDelete.svg(
                      colorFilter: colorFilter,
                      width: 18.w,
                      height: 18.w,
                    ),
                  ),
                  label: t.event.eventPhotos.deletePhoto,
                  value: _PhotoActions.delete,
                ),
              ],
              child: ThemeSvgIcon(
                color: colorScheme.onPrimary,
                builder: (colorFilter) => Assets.icons.icMoreHoriz.svg(
                  colorFilter: colorFilter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
