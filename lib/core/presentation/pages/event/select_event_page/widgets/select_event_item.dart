import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectEventItem extends StatelessWidget {
  final Event event;
  const SelectEventItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.chineseBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        children: [
          LemonNetworkImage(
            width: Sizing.medium,
            height: Sizing.medium,
            borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            imageUrl: EventUtils.getEventThumbnailUrl(
              event: event,
            ),
            placeholder: ImagePlaceholder.defaultPlaceholder(
              radius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                event.title ?? '',
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                EventUtils.formatDateWithTimezone(
                  dateTime: event.start ?? DateTime.now(),
                  timezone: event.timezone ?? '',
                  format: DateTimeFormat.fullDateWithTime,
                ),
                style: Typo.small.copyWith(
                  color: colorScheme.onSecondary,
                ),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: ThemeSvgIcon(
              color: colorScheme.onSecondary,
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
