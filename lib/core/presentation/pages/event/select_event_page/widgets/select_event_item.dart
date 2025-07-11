import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class SelectEventItem extends StatelessWidget {
  final Event event;
  const SelectEventItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return Container(
      padding: EdgeInsets.all(Spacing.s3),
      decoration: BoxDecoration(
        color: appColors.cardBg,
        borderRadius: BorderRadius.circular(LemonRadius.md),
      ),
      child: Row(
        children: [
          LemonNetworkImage(
            width: Sizing.s9,
            height: Sizing.s9,
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            border: Border.all(
              color: appColors.pageDivider,
            ),
            imageUrl: EventUtils.getEventThumbnailUrl(
              event: event,
            ),
            placeholder: ImagePlaceholder.eventCard(),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  event.title ?? '',
                  style: appText.md,
                ),
                SizedBox(height: 2.w),
                Text(
                  DateFormatUtils.dateWithTimezone(
                    dateTime: event.start ?? DateTime.now(),
                    timezone: event.timezone ?? '',
                    pattern: DateFormatUtils.fullDateFormat,
                  ),
                  style: appText.sm.copyWith(
                    color: appColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: ThemeSvgIcon(
              color: appColors.textTertiary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                colorFilter: filter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
