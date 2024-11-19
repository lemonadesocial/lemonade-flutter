import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/widgets/home_event_card_footer_left.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/widgets/home_event_card_footer_right.dart';

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
                              DateFormatUtils.dateWithTimezone(
                                dateTime: event.start ?? DateTime.now(),
                                timezone: event.timezone ?? '',
                                pattern: 'EEE, d MMM h:mm a',
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
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.address?.street1 ?? '',
                                          style: Typo.small.copyWith(
                                            color: colorScheme.onSecondary,
                                          ),
                                        ),
                                        SizedBox(height: Spacing.superExtraSmall / 2),
                                        Text(
                                          event.address?.additionalDirections ??
                                              '',
                                          style: Typo.small.copyWith(
                                            color: colorScheme.onSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        SizedBox(height: Spacing.small / 2),
                        Row(
                          children: [
                            LemonNetworkImage(
                              imageUrl: event.hostExpanded?.imageAvatar ?? '',
                              width: Sizing.mSmall,
                              height: Sizing.mSmall,
                              borderRadius:
                                  BorderRadius.circular(Sizing.mSmall),
                              placeholder: ImagePlaceholder.avatarPlaceholder(),
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            Text(
                              (cohostsCount ?? 0) > 0
                                  ? '${event.hostExpanded?.name} + $cohostsCount'
                                  : event.hostExpanded?.name ?? '',
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Container(
                    width: 80.w,
                    height: 80.w,
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
                  HomeEventCardFooterLeft(event: event),
                  const Spacer(),
                  HomeEventCardFooterRight(
                    event: event,
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
