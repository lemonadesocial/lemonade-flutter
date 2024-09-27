import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SpotlightEventItem extends StatelessWidget {
  const SpotlightEventItem({
    super.key,
    required this.event,
  });
  final Event event;

  DbFile? get eventPhoto => event.newNewPhotosExpanded?.isNotEmpty ?? false
      ? event.newNewPhotosExpanded!.first
      : null;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 128.w,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            LemonRadius.small,
          ),
          side: BorderSide(
            width: 1.w,
            color: colorScheme.outline,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                LemonRadius.small,
              ),
              child: CachedNetworkImage(
                imageUrl: ImageUtils.generateUrl(
                  file: eventPhoto,
                  imageConfig: ImageConfig.eventPhoto,
                ),
                errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
                placeholder: (_, __) => ImagePlaceholder.eventCard(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 0.8,
                  colors: [
                    LemonColor.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Spacing.superExtraSmall,
            right: Spacing.superExtraSmall,
            child: _EventJoinCount(count: event.accepted?.length ?? 0),
          ),
          Positioned(
            left: Spacing.xSmall,
            bottom: Spacing.xSmall,
            child: _EventInfo(event),
          ),
        ],
      ),
    );
  }
}

class _EventInfo extends StatelessWidget {
  const _EventInfo(this.event);
  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            event.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Typo.small.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
              height: 0,
            ),
          ),
        ),
        SizedBox(
          height: 2.w,
        ),
        Text(
          EventUtils.formatDateWithTimezone(
            dateTime: event.start ?? DateTime.now(),
            timezone: event.timezone ?? '',
            format: DateTimeFormat.dateOnly,
          ),
          maxLines: 1,
          style: Typo.xSmall.copyWith(
            fontSize: 9.sp,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _EventJoinCount extends StatelessWidget {
  const _EventJoinCount({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.superExtraSmall),
      decoration: ShapeDecoration(
        color: colorScheme.primary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            LemonRadius.extraSmall,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ThemeSvgIcon(
            color: colorScheme.onPrimary,
            builder: (filter) =>
                Assets.icons.icProfile.svg(colorFilter: filter),
          ),
          SizedBox(width: Spacing.superExtraSmall / 2),
          Text(
            NumberFormat.compact().format(count),
            style: Typo.xSmall.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
