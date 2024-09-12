import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/color.dart';

class CreateEventBannerPhotoCard extends StatelessWidget {
  const CreateEventBannerPhotoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color: LemonColor.white06,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Stack(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => ImagePlaceholder.eventCard(),
              errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
              imageUrl: "",
            ),
            Positioned(
              right: Spacing.small,
              bottom: Spacing.small,
              child: Container(
                padding: EdgeInsets.all(Sizing.xxSmall),
                decoration: ShapeDecoration(
                  color: LemonColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(LemonRadius.normal),
                  ),
                ),
                child: ThemeSvgIcon(
                  color: colorScheme.surfaceVariant,
                  builder: (filter) => Assets.icons.icUpload.svg(
                    width: Sizing.xSmall,
                    height: Sizing.xSmall,
                    colorFilter: filter,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
