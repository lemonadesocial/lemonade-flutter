import 'dart:ui';

import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailClock extends StatelessWidget {
  const GuestEventDetailClock({
    super.key,
    required this.event,
  });

  final Event event;

  Duration? get durationToEvent {
    if (event.start == null) return null;
    var now = DateTime.now();

    if (event.start!.isBefore(now)) return null;

    return event.start!.difference(now);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 100,
                  sigmaY: 50,
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: EventUtils.getEventThumbnailUrl(event: event),
                  errorWidget: (context, url, error) =>
                      ImagePlaceholder.defaultPlaceholder(),
                  placeholder: (context, url) =>
                      ImagePlaceholder.defaultPlaceholder(),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.smMedium,
              horizontal: Spacing.smMedium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.outline),
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: EventUtils.getEventThumbnailUrl(event: event),
                      errorWidget: (context, url, error) =>
                          ImagePlaceholder.defaultPlaceholder(),
                      placeholder: (context, url) =>
                          ImagePlaceholder.defaultPlaceholder(),
                    ),
                  ),
                ),
                SizedBox(width: Spacing.small),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title ?? '',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 3.w),
                      Text(
                        durationToEvent != null
                            ? t.event.eventStartIn(
                                time: printDuration(
                                  durationToEvent!,
                                  tersity: (durationToEvent?.inDays ?? 0) < 1
                                      ? (durationToEvent?.inHours ?? 0) >= 1
                                          ? DurationTersity.hour
                                          : DurationTersity.minute
                                      : DurationTersity.day,
                                  upperTersity: DurationTersity.day,
                                ),
                              )
                            : t.event.eventEnded,
                        style: Typo.mediumPlus.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w800,
                          fontFamily: FontFamily.nohemiVariable,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Spacing.small),
                InkWell(
                  onTap: () {
                    AutoRouter.of(context).navigate(
                      MyEventTicketRoute(
                        event: event,
                      ),
                    );
                  },
                  child: Container(
                    width: Sizing.medium,
                    height: Sizing.medium,
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(LemonRadius.xSmall),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          ThemeSvgIcon(
                            color: colorScheme.onSecondary,
                            builder: (filter) => Assets.icons.icTicketBold
                                .svg(colorFilter: filter),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
