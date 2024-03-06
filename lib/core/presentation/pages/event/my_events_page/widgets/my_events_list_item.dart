import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyEventsListItem extends StatelessWidget {
  final Event event;
  const MyEventsListItem({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).navigate(
          EventDetailRoute(
            eventId: event.id ?? '',
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(
            LemonRadius.small,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(Spacing.smMedium),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 42.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: LemonColor.white09,
                          ),
                          borderRadius: BorderRadius.circular(
                            LemonRadius.extraSmall,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            LemonRadius.extraSmall,
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: EventUtils.getEventThumbnailUrl(
                              event: event,
                            ),
                            errorWidget: (context, url, error) =>
                                ImagePlaceholder.defaultPlaceholder(),
                            placeholder: (context, url) =>
                                ImagePlaceholder.defaultPlaceholder(),
                          ),
                        ),
                      ),
                      SizedBox(width: Spacing.small),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              event.title ?? '',
                              style: Typo.medium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormatUtils.custom(
                                    event.start,
                                    pattern: 'E, dd MMM yyyy',
                                  ),
                                  style: Typo.small.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                                SizedBox(
                                  width: Spacing.superExtraSmall,
                                ),
                                Container(
                                  width: 2.w,
                                  height: 2.h,
                                  decoration: ShapeDecoration(
                                    color: colorScheme.onSurfaceVariant,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(LemonRadius.xSmall),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: Spacing.superExtraSmall,
                                    ),
                                    ThemeSvgIcon(
                                      color: colorScheme.onSecondary,
                                      builder: (filter) =>
                                          Assets.icons.icProfileOutline.svg(
                                        colorFilter: filter,
                                        width: Sizing.small / 2,
                                        height: Sizing.small / 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Spacing.superExtraSmall,
                                    ),
                                    Text(
                                      event.invitedCount.toString(),
                                      style: Typo.small.copyWith(
                                        color: colorScheme.onSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
