import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
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
                              width: 2,
                              height: 2,
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
                                  Icon(Icons.location_on,
                                      size: 16, color: colorScheme.onSecondary),
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
                              size: 25.w,
                            ),
                            SizedBox(width: Spacing.extraSmall),
                            Text(
                              event.hostExpanded?.name ?? '',
                              style: Typo.small.copyWith(
                                color: colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.09),
                        ),
                        borderRadius: BorderRadius.circular(4),
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
                      Icon(
                        Icons.people,
                        size: 16,
                        color: colorScheme.onSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '234/500',
                        style: TextStyle(
                          color: colorScheme.onSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Row(
                    children: [
                      Icon(Icons.pending,
                          size: 16, color: colorScheme.onSecondary),
                      const SizedBox(width: 6),
                      Text(
                        '3 pending',
                        style: TextStyle(
                          color: colorScheme.onSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.09),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Manage',
                          style: TextStyle(
                            color: colorScheme.onSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(Icons.settings,
                            size: 12, color: colorScheme.onSecondary),
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
