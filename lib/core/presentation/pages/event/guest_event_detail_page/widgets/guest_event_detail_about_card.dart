import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_detail_about_bottom_sheet.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailAboutCard extends StatelessWidget {
  const GuestEventDetailAboutCard({
    super.key,
    required this.event,
  });

  final Event event;

  String get photoUrl {
    if (event.newNewPhotosExpanded == null ||
        event.newNewPhotosExpanded!.isEmpty) {
      return '';
    }

    return ImageUtils.generateUrl(
      file: event.newNewPhotosExpanded?.first,
      imageConfig: ImageConfig.eventPhoto,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: photoUrl,
                errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
                placeholder: (_, __) => ImagePlaceholder.eventCard(),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: colorScheme.primary.withOpacity(0.9),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Spacing.large,
              right: Spacing.medium,
              bottom: Spacing.medium,
              left: Spacing.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.event.aboutTheEvent,
                  style: Typo.extraMedium.copyWith(
                    fontFamily: FontFamily.nohemiVariable,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3.w),
                Text(
                  '${event.title ?? ''}  •  ${DateFormatUtils.dateOnly(event.start)}',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                  height: Spacing.smMedium,
                ),
                Text(
                  event.description ?? '',
                  style: Typo.mediumPlus.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: Spacing.medium,
                ),
                InkWell(
                  onTap: () {
                    BottomSheetUtils.showSnapBottomSheet(
                      context,
                      builder: (context) =>
                          GuestEventDetailAboutBottomSheet(event: event),
                    );
                  },
                  child: Container(
                    height: 42.w,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.button),
                      color: colorScheme.secondary,
                    ),
                    child: Center(
                      child: Text(
                        t.common.viewMore,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontFamily: FontFamily.switzerVariable,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
