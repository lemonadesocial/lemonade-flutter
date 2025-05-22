import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class EventReservationsListItemWidget extends StatelessWidget {
  final Event event;

  const EventReservationsListItemWidget({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.small,
        vertical: Spacing.smMedium,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Event pic
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: appColors.pageDivider,
              ),
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: Sizing.xLarge,
                height: Sizing.medium,
                imageUrl: EventUtils.getEventThumbnailUrl(event: event),
                placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                errorWidget: (_, __, ___) =>
                    ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
          ),
          SizedBox(width: Spacing.small),
          // event name and tickets info
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title ?? '',
                  style: appText.md,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.w),
                Text(
                  DateFormatUtils.dateWithTimezone(
                    dateTime: event.start ?? DateTime.now(),
                    timezone: event.timezone ?? '',
                  ),
                  style: appText.sm.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Spacing.small),
          SizedBox(width: Spacing.xSmall),
          // dot horizontal
          ThemeSvgIcon(
            color: appColors.textTertiary,
            builder: (filter) =>
                Assets.icons.icMoreHoriz.svg(colorFilter: filter),
          ),
        ],
      ),
    );
  }
}
