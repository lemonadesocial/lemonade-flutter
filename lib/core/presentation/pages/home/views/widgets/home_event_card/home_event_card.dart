import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_event_card/widgets/home_event_card_footer.dart';

class HomeEventCard extends StatelessWidget {
  final Event event;
  const HomeEventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final appTextTheme = Theme.of(context).appTextTheme;
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => '',
        );
    final isAttending = EventUtils.isAttending(event: event, userId: userId);
    final isOwnEvent = EventUtils.isOwnEvent(event: event, userId: userId);

    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          EventDetailRoute(
            eventId: event.id ?? '',
          ),
        );
      },
      child: Container(
        decoration: ShapeDecoration(
          color: appColors.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LemonRadius.md),
          ),
        ),
        padding: EdgeInsets.all(Spacing.s3),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: event.address == null ? 94.w : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: event.address == null
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            LemonNetworkImage(
                              imageUrl: event.hostExpanded?.imageAvatar ?? '',
                              width: Spacing.s4,
                              height: Spacing.s4,
                              borderRadius:
                                  BorderRadius.circular(LemonRadius.full),
                              placeholder: ImagePlaceholder.avatarPlaceholder(),
                            ),
                            SizedBox(width: Spacing.s1_5),
                            Text(
                              event.hostExpanded?.name ?? '',
                              style: appTextTheme.xs.copyWith(
                                color: appColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Spacing.s1),
                        Text(
                          event.title ?? '',
                          style: appTextTheme.md.copyWith(
                            color: appColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: Spacing.s1),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Date row
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: Spacing.s4,
                                  color: appColors.textTertiary,
                                ),
                                SizedBox(width: Spacing.s2),
                                Text(
                                  DateFormatUtils.dateWithTimezone(
                                    dateTime: event.start ?? DateTime.now(),
                                    timezone: event.timezone ?? '',
                                    pattern: 'EEE, d MMM, h:mm a',
                                    withTimezoneOffset: false,
                                  ),
                                  style: appTextTheme.sm.copyWith(
                                    color: appColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            if (event.address != null) ...[
                              SizedBox(height: Spacing.s1),
                              // Location row
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: Spacing.s4,
                                    color: appColors.textTertiary,
                                  ),
                                  SizedBox(width: Spacing.s2),
                                  Expanded(
                                    child: Text(
                                      EventUtils.getAddress(
                                        event: event,
                                        showFullAddress: false,
                                        isAttending: isAttending,
                                        isOwnEvent: isOwnEvent,
                                      ),
                                      style: appTextTheme.sm.copyWith(
                                        color: appColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Spacing.s3),
                Container(
                  width: 94.w,
                  height: 94.w,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: LemonColor.white09,
                      ),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => ImagePlaceholder.eventCard(),
                      errorWidget: (_, __, ___) => ImagePlaceholder.eventCard(),
                      imageUrl: ImageUtils.generateUrl(
                        file: event.newNewPhotosExpanded?.firstOrNull,
                        imageConfig: ImageConfig.eventPhoto,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.s2),
            HomeEventCardFooter(
              status: isAttending
                  ? EventAttendanceStatus.going
                  : EventAttendanceStatus.hosting,
            ),
          ],
        ),
      ),
    );
  }
}
