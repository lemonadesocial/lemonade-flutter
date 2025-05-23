import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpaceEventRequestItem extends StatelessWidget {
  const SpaceEventRequestItem({
    super.key,
    required this.request,
    this.onApprove,
    this.onDecline,
  });

  final SpaceEventRequest request;
  final Function(SpaceEventRequest)? onApprove;
  final Function(SpaceEventRequest)? onDecline;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    final event = request.eventExpanded;
    if (event == null) {
      return const SizedBox.shrink();
    }
    final dateFormat = DateFormat('EEE, dd MMM');
    final timeFormat = DateFormat('h:mm a');
    final eventDate = event.start != null
        ? '${dateFormat.format(event.start!)} • ${timeFormat.format(event.start!)}'
        : '--';
    final isVirtual = event.virtual ?? false;
    final location =
        isVirtual ? t.event.virtual : EventUtils.getAddress(event: event);
    final guestCount = (event.guests ?? 0).toInt();
    final attendeeCount = '$guestCount ${t.common.guest(n: guestCount)}';

    return InkWell(
      onTap: () {
        if (request.event == null) {
          return;
        }
        AutoRouter.of(context).push(
          EventDetailRoute(eventId: request.event!),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.s3),
        decoration: BoxDecoration(
          color: appColors.cardBg,
          borderRadius: BorderRadius.circular(LemonRadius.md),
          border: Border.all(
            color: appColors.cardBorder,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title ?? '',
                        style: appText.md,
                      ),
                      SizedBox(height: Spacing.s2),
                      // Event info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date
                          Row(
                            children: [
                              ThemeSvgIcon(
                                color: appColors.textTertiary,
                                builder: (colorFilter) =>
                                    Assets.icons.icCalendarTodayOutline.svg(
                                  colorFilter: colorFilter,
                                  width: Sizing.s5,
                                  height: Sizing.s5,
                                ),
                              ),
                              SizedBox(width: Spacing.s2),
                              Expanded(
                                child: Text(
                                  eventDate,
                                  style: appText.sm.copyWith(
                                    color: appColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Spacing.s1),
                          // Location
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ThemeSvgIcon(
                                color: appColors.textTertiary,
                                builder: (colorFilter) => isVirtual
                                    ? Assets.icons.icLive.svg(
                                        colorFilter: colorFilter,
                                        width: Sizing.s5,
                                        height: Sizing.s5,
                                      )
                                    : Assets.icons.icLocationPinOutline.svg(
                                        colorFilter: colorFilter,
                                        width: Sizing.s5,
                                        height: Sizing.s5,
                                      ),
                              ),
                              SizedBox(width: Spacing.s2),
                              Expanded(
                                child: Text(
                                  location,
                                  style: appText.sm.copyWith(
                                    color: appColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Spacing.s1),
                          Row(
                            children: [
                              ThemeSvgIcon(
                                color: appColors.textTertiary,
                                builder: (colorFilter) =>
                                    Assets.icons.icPersonOutline.svg(
                                  colorFilter: colorFilter,
                                  width: Sizing.s5,
                                  height: Sizing.s5,
                                ),
                              ),
                              SizedBox(width: Spacing.s2),
                              FutureBuilder(
                                future: request.createdBy?.isNotEmpty == true
                                    ? getIt<UserRepository>().getUserProfile(
                                        GetProfileInput(
                                          id: request.createdBy,
                                        ),
                                      )
                                    : Future.value(null),
                                builder: (context, snapshot) {
                                  final user = snapshot.data?.fold(
                                    (l) => null,
                                    (user) => user,
                                  );
                                  return Text(
                                    '${t.space.submittedBy} ${user?.displayName ?? user?.name ?? '--'}',
                                    style: appText.sm.copyWith(
                                      color: appColors.textSecondary,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: Spacing.s1),
                          // Attendees
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ThemeSvgIcon(
                                color: appColors.textTertiary,
                                builder: (colorFilter) =>
                                    Assets.icons.icGroupOutline.svg(
                                  colorFilter: colorFilter,
                                  width: Sizing.s5,
                                  height: Sizing.s5,
                                ),
                              ),
                              SizedBox(width: Spacing.s2),
                              Expanded(
                                child: Text(
                                  attendeeCount,
                                  style: appText.sm.copyWith(
                                    color: appColors.textSecondary,
                                  ),
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
            SizedBox(height: Spacing.s3),
            if (request.state == Enum$SpaceEventRequestState.approved ||
                request.state == Enum$SpaceEventRequestState.declined)
              Row(
                children: [
                  ThemeSvgIcon(
                    color: appColors.textTertiary,
                    builder: (colorFilter) =>
                        request.state == Enum$SpaceEventRequestState.approved
                            ? Assets.icons.icDone.svg(
                                width: Sizing.s5,
                                height: Sizing.s5,
                                colorFilter: colorFilter,
                              )
                            : Assets.icons.icClose.svg(
                                width: Sizing.s5,
                                height: Sizing.s5,
                                colorFilter: colorFilter,
                              ),
                  ),
                  SizedBox(width: Spacing.extraSmall),
                  FutureBuilder(
                    future: request.decidedBy?.isNotEmpty == true
                        ? getIt<UserRepository>().getUserProfile(
                            GetProfileInput(
                              id: request.decidedBy,
                            ),
                          )
                        : Future.value(null),
                    builder: (context, snapshot) {
                      final user = snapshot.data?.fold(
                        (l) => null,
                        (user) => user,
                      );
                      final actionText =
                          request.state == Enum$SpaceEventRequestState.approved
                              ? t.space.approvedBy
                              : t.space.declinedBy;
                      final name = user?.displayName ?? user?.name ?? '--';
                      return Text(
                        '$actionText $name',
                        style: appText.sm.copyWith(
                          color: appColors.textSecondary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            if (request.state == Enum$SpaceEventRequestState.pending)
              Row(
                children: [
                  Expanded(
                    child: LemonOutlineButton(
                      label: t.space.approve,
                      onTap:
                          onApprove != null ? () => onApprove!(request) : null,
                      textStyle: appText.md.copyWith(
                        color: appColors.textPrimary,
                      ),
                      backgroundColor: appColors.buttonSuccessBg,
                    ),
                  ),
                  SizedBox(width: Spacing.s1_5),
                  Expanded(
                    child: LemonOutlineButton(
                      label: t.space.decline,
                      onTap:
                          onDecline != null ? () => onDecline!(request) : null,
                      textStyle: appText.md.copyWith(
                        color: appColors.textPrimary,
                      ),
                      backgroundColor: appColors.buttonErrorBg,
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
