import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventInfoSummary extends StatelessWidget {
  final Event event;

  const EventInfoSummary({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        border: Border.all(
          color: colorScheme.outline,
          width: 0.5.w,
        ),
        borderRadius: BorderRadius.circular(
          LemonRadius.normal,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Spacing.small),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LemonNetworkImage(
                  imageUrl: EventUtils.getEventThumbnailUrl(event: event),
                  width: 18.w,
                  height: 18.w,
                  placeholder: ImagePlaceholder.eventCard(),
                  borderRadius: BorderRadius.circular(3.r),
                ),
                SizedBox(width: Spacing.xSmall),
                Text(
                  event.title ?? '',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.5.w,
            color: colorScheme.outline,
          ),
          Padding(
            padding: EdgeInsets.all(Spacing.small),
            child: Column(
              children: [
                Row(
                  children: [
                    ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icCalendar.svg(
                        colorFilter: filter,
                      ),
                    ),
                    SizedBox(width: Spacing.xSmall),
                    Text(
                      DateFormatUtils.fullDateWithTime(event.start),
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                if (event.address != null) ...[
                  SizedBox(height: Spacing.xSmall),
                  Row(
                    children: [
                      ThemeSvgIcon(
                        color: colorScheme.onSecondary,
                        builder: (filter) => Assets.icons.icLocationPin.svg(
                          colorFilter: filter,
                        ),
                      ),
                      SizedBox(width: Spacing.xSmall),
                      Text(
                        event.address?.title ?? '',
                        style: Typo.medium.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
