import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeEventCard extends StatelessWidget {
  final Event event;
  const HomeEventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cohostsCount = event.cohosts?.length;
    final guestsCount = event.guests;
    final checkInCount = event.checkInCount;
    final pendingRequestsCount = event.pendingRequestCount ?? 0;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).navigate(
          EventDetailRoute(
            eventId: event.id ?? '',
          ),
        );
      },
      child: Container(
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.outline,
              LemonColor.white06,
            ],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: LemonColor.white03,
            ),
            borderRadius: BorderRadius.circular(LemonRadius.medium),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title ?? '',
                          style: Typo.medium.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        SizedBox(height: Spacing.extraSmall),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: Sizing.xSmall,
                              color: colorScheme.onSecondary,
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            Text(
                              DateFormat('EEE, d MMM').format(
                                event.start?.toLocal() ?? DateTime.now(),
                              ),
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            Container(
                              width: 3.w,
                              height: 3.w,
                              decoration: BoxDecoration(
                                color: LemonColor.white18,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            Text(
                              DateFormat('h:mm a').format(
                                event.start?.toLocal() ?? DateTime.now(),
                              ),
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Spacing.small / 2),
                        if ((event.address?.street1 ?? '').isNotEmpty)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: Sizing.mSmall,
                                    color: colorScheme.onSecondary,
                                  ),
                                  SizedBox(width: Spacing.extraSmall),
                                  Expanded(
                                    child: Text(
                                      event.address?.street1 ?? '',
                                      style: Typo.small.copyWith(
                                        color: colorScheme.onSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Spacing.small / 2),
                            ],
                          ),
                        Row(
                          children: [
                            LemonCircleAvatar(
                              url: event.hostExpanded?.imageAvatar ?? '',
                              size: Sizing.mSmall,
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            Text(
                              (cohostsCount ?? 0) > 0
                                  ? '${event.hostExpanded!.name} + $cohostsCount'
                                  : event.hostExpanded?.name ?? '',
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: LemonColor.white09,
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(LemonRadius.extraSmall),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => ImagePlaceholder.eventCard(),
                        errorWidget: (_, __, ___) =>
                            ImagePlaceholder.eventCard(),
                        imageUrl: ImageUtils.generateUrl(
                          file: event.newNewPhotosExpanded?.firstOrNull,
                          imageConfig: ImageConfig.eventPhoto,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: colorScheme.outline,
            ),
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                children: [
                  Row(
                    children: [
                      ThemeSvgIcon(
                        builder: (colorFilter) => Assets.icons.icGuests.svg(
                          width: Sizing.mSmall,
                          height: Sizing.mSmall,
                        ),
                      ),
                      SizedBox(width: Spacing.superExtraSmall),
                      Text(
                        '$checkInCount/$guestsCount',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 14.w),
                  if (pendingRequestsCount > 0)
                    Row(
                      children: [
                        ThemeSvgIcon(
                          builder: (colorFilter) => Assets.icons.icError.svg(
                            width: Sizing.mSmall,
                            height: Sizing.mSmall,
                          ),
                        ),
                        SizedBox(width: Spacing.superExtraSmall),
                        Text(
                          t.event.pendingCount(n: pendingRequestsCount),
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                    decoration: ShapeDecoration(
                      color: LemonColor.white09,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          LemonRadius.small / 2,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Manage',
                          style: Typo.small.copyWith(
                            color: colorScheme.onSecondary,
                            height: 0,
                          ),
                        ),
                        const SizedBox(width: 6),
                        ThemeSvgIcon(
                          color: colorScheme.onSurfaceVariant,
                          builder: (filter) => Assets.icons.icArrowRight.svg(
                            width: 15.w,
                            height: 15.w,
                            colorFilter: filter,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
