import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/space/widgets/space_event_card/widgets/space_event_card_footer_left.dart';
import 'package:app/core/presentation/pages/space/widgets/space_event_card/widgets/space_event_card_footer_right.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/core/utils/image_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class SpaceEventCard extends StatelessWidget {
  final Event event;
  const SpaceEventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cohostsCount = event.cohosts?.length;
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => '',
        );
    final isAttending = EventUtils.isAttending(event: event, userId: userId);
    final isOwnEvent = EventUtils.isOwnEvent(event: event, userId: userId);
    final eventAddress = EventUtils.getAddress(
      event: event,
      showFullAddress: false,
      isAttending: isAttending,
      isOwnEvent: isOwnEvent,
    );
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

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
            side: BorderSide(
              color: appColors.cardBorder,
            ),
            borderRadius: BorderRadius.circular(LemonRadius.md),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(Spacing.s3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        SizedBox(height: Spacing.s1),
                        Text(
                          event.title ?? '',
                          style: appText.md,
                        ),
                        SizedBox(height: Spacing.s1),
                        Row(
                          children: [
                            ThemeSvgIcon(
                              color: appColors.textTertiary,
                              builder: (filter) =>
                                  Assets.icons.icAccessTimeOutline.svg(
                                width: Sizing.s4,
                                height: Sizing.s4,
                                colorFilter: filter,
                              ),
                            ),
                            SizedBox(width: Spacing.s2),
                            Expanded(
                              child: Text(
                                DateFormatUtils.dateWithTimezone(
                                  dateTime: event.start ?? DateTime.now(),
                                  timezone: event.timezone ?? '',
                                  pattern: 'EEE, d MMM HH:MM',
                                ),
                                style: appText.sm.copyWith(
                                  color: appColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (eventAddress.isNotEmpty) ...[
                          SizedBox(height: Spacing.small / 2),
                          Row(
                            children: [
                              ThemeSvgIcon(
                                color: appColors.textTertiary,
                                builder: (filter) =>
                                    Assets.icons.icLocationPinOutline.svg(
                                  width: Sizing.s4,
                                  height: Sizing.s4,
                                  colorFilter: filter,
                                ),
                              ),
                              SizedBox(width: Spacing.s2),
                              Expanded(
                                child: Text(
                                  eventAddress,
                                  style: appText.sm.copyWith(
                                    color: appColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(width: Spacing.s3),
                  LemonNetworkImage(
                    width: 94.w,
                    height: 94.w,
                    fit: BoxFit.cover,
                    border: Border.all(
                      color: appColors.cardBorder,
                    ),
                    borderRadius: BorderRadius.circular(6.r),
                    imageUrl: ImageUtils.generateUrl(
                      file: event.newNewPhotosExpanded?.firstOrNull,
                      imageConfig: ImageConfig.eventPhoto,
                    ),
                    placeholder: ImagePlaceholder.eventCard(),
                  ),
                ],
              ),
              SizedBox(height: Spacing.s2),
              Row(
                children: [
                  SpaceEventCardFooterLeft(event: event),
                  const Spacer(),
                  SpaceEventCardFooterRight(
                    event: event,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
