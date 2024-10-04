import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailPhotos extends StatelessWidget {
  const GuestEventDetailPhotos({
    super.key,
    required this.event,
    this.showTitle = true,
  });

  final Event event;
  final bool? showTitle;

  List<String> get photoUrls {
    return (event.newNewPhotosExpanded ?? [])
        .skip(1)
        .map(
          (item) => ImageUtils.generateUrl(
            file: item,
            imageConfig: ImageConfig.eventPoster,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    if (photoUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showTitle!) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: Text(
              StringUtils.capitalize(t.common.photo(n: 2)),
              style: Typo.mediumPlus.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          SizedBox(
            height: Spacing.xSmall,
          ),
        ],
        SizedBox(
          height: 144.w,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(
              width: Spacing.extraSmall,
            ),
            itemCount: photoUrls.length,
            itemBuilder: (context, index) {
              final photo = photoUrls[index];
              return Hero(
                tag: photo,
                child: GestureDetector(
                  onTap: () {
                    AutoRouter.of(context).push(
                      PhotosGalleryRoute(
                        initialIndex: index,
                        photos: photoUrls,
                        title: Text(
                          event.title ?? '',
                          style: Typo.extraMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 144.w,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        side: BorderSide(color: colorScheme.outline),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            ImagePlaceholder.defaultPlaceholder(),
                        errorWidget: (_, __, ___) =>
                            ImagePlaceholder.defaultPlaceholder(),
                        imageUrl: photo,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
