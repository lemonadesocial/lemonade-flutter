import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/event/entities/event_user_role.dart';
import 'package:app/core/domain/event/input/get_tickets_input/get_tickets_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/event_approval_setting_page.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/feature_manager/feature_manager.dart';
import 'package:app/core/service/feature_manager/event_role_based_feature_visibility_strategy.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:slang/builder/utils/string_extensions.dart';

class HostEventBasicInfoCard extends StatelessWidget {
  const HostEventBasicInfoCard({
    super.key,
    required this.event,
    required this.eventUserRole,
  });

  final Event event;
  final EventUserRole? eventUserRole;

  String? get durationText {
    final now = DateTime.now();
    if (event.start == null && event.end == null) return null;
    // Is Live event
    if (event.start!.isBefore(now) && event.end!.isAfter(now)) {
      final Duration difference = now.difference(event.start!);
      final int days = difference.inDays;
      if (days == 0) {
        return t.event.eventStarted;
      }
      return t.event.eventStartedDaysAgo(days: days);
    }
    // Is upcoming event
    else if (event.start!.isAfter(now) && event.end!.isAfter(now)) {
      final durationToEvent = event.start!.difference(now);
      return t.event.eventStartIn(
        time: prettyDuration(
          durationToEvent,
          tersity: (durationToEvent.inDays) < 1
              ? (durationToEvent.inHours) >= 1
                  ? DurationTersity.hour
                  : DurationTersity.minute
              : DurationTersity.day,
          upperTersity: DurationTersity.day,
        ),
      );
    }
    return t.event.eventEnded;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final userId = AuthUtils.getUserId(context);
    final relayPaymentSupported = event.paymentAccountsExpanded?.any(
          (element) => element.type == PaymentAccountType.ethereumRelay,
        ) ??
        false;
    final featureManager =
        FeatureManager(EventRoleBasedFeatureVisibilityStrategy());
    final canShowGuestList =
        featureManager.canShowGuestList(eventUserRole: eventUserRole);
    final canShowEventSettings =
        featureManager.canShowEventSettings(eventUserRole: eventUserRole);

    return FutureBuilder<Either<Failure, List<EventTicket>>>(
      future: getIt<EventTicketRepository>().getTickets(
        input: GetTicketsInput(
          event: event.id,
          user: userId,
        ),
      ),
      builder: (context, snapshot) {
        return Column(
          children: [
            Container(
              height: 78.w,
              decoration: BoxDecoration(
                color: colorScheme.onPrimary.withOpacity(0.06),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.r),
                  topLeft: Radius.circular(15.r),
                  bottomLeft: Radius.circular(6.r),
                  bottomRight: Radius.circular(6.r),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
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
                                      border: Border.all(
                                        color: colorScheme.outline,
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
                                        imageUrl:
                                            EventUtils.getEventThumbnailUrl(
                                          event: event,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            ImagePlaceholder
                                                .defaultPlaceholder(),
                                        placeholder: (context, url) =>
                                            ImagePlaceholder
                                                .defaultPlaceholder(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Spacing.small),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.title ?? '',
                                          style: Typo.small.copyWith(
                                            color: colorScheme.onSecondary,
                                            fontWeight: FontWeight.w400,
                                            fontFamily:
                                                FontFamily.switzerVariable,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          durationText ?? '',
                                          style: Typo.mediumPlus.copyWith(
                                            color: colorScheme.onPrimary,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                FontFamily.nohemiVariable,
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
                      if (canShowEventSettings) const _EditEventButton(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Spacing.extraSmall,
            ),
            if (canShowGuestList)
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => AutoRouter.of(context).push(
                        EventApprovalSettingRoute(
                          initialTab: EventGuestsTabs.checkins,
                        ),
                      ),
                      child: Container(
                        height: 73.w,
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.06),
                          borderRadius: BorderRadius.all(
                            Radius.circular(LemonRadius.extraSmall),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: Spacing.smMedium),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.checkInCount?.toString() ?? '',
                                style: Typo.mediumPlus.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontFamily: FontFamily.nohemiVariable,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                t.event.checkedIn.capitalize(),
                                style: Typo.small
                                    .copyWith(color: colorScheme.onSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Spacing.extraSmall,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => AutoRouter.of(context).push(
                        EventApprovalSettingRoute(
                          initialTab: EventGuestsTabs.reservations,
                        ),
                      ),
                      child: Container(
                        height: 73.w,
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.06),
                          borderRadius: BorderRadius.all(
                            Radius.circular(LemonRadius.extraSmall),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: Spacing.smMedium),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.attendingCount?.toString() ?? '',
                                style: Typo.mediumPlus.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontFamily: FontFamily.nohemiVariable,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                t.event.attending.capitalize(),
                                style: Typo.small
                                    .copyWith(color: colorScheme.onSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Spacing.extraSmall,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => AutoRouter.of(context).push(
                        EventApprovalSettingRoute(
                          initialTab: EventGuestsTabs.invited,
                        ),
                      ),
                      child: Container(
                        height: 73.w,
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withOpacity(0.06),
                          borderRadius: BorderRadius.all(
                            Radius.circular(LemonRadius.extraSmall),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: Spacing.smMedium),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.invitedCount?.toString() ?? '',
                                style: Typo.mediumPlus.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontFamily: FontFamily.nohemiVariable,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                t.event.invited.capitalize(),
                                style: Typo.small
                                    .copyWith(color: colorScheme.onSecondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (canShowGuestList)
              SizedBox(
                height: Spacing.extraSmall,
              ),
            if (relayPaymentSupported) ...[
              _ClaimRelayPaymentButton(event: event),
              SizedBox(
                height: Spacing.extraSmall,
              ),
            ],
            if (canShowGuestList) _ViewGuestsButton(event: event),
          ],
        );
      },
    );
  }
}

class _ClaimRelayPaymentButton extends StatelessWidget {
  final Event event;
  const _ClaimRelayPaymentButton({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          ClaimSplitRelayPaymentRoute(
            event: event,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.smMedium),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withOpacity(0.06),
          borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: LemonColor.malachiteGreen,
              builder: (filter) => Assets.icons.icCashVariant.svg(
                width: 18.w,
                height: 18.w,
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.extraSmall),
            Text(
              t.event.relayPayment.claimSplit.saleSplit,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
            ),
            const Spacer(),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                width: 18.w,
                height: 18.w,
                colorFilter: filter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewGuestsButton extends StatelessWidget {
  const _ViewGuestsButton({
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        Vibrate.feedback(FeedbackType.light);
        AutoRouter.of(context).push(
          EventApprovalSettingRoute(
            initialTab:
                event.approvalRequired == true ? EventGuestsTabs.pending : null,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(
          Spacing.smMedium,
        ),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary.withOpacity(0.06),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(LemonRadius.medium),
            bottomLeft: Radius.circular(LemonRadius.medium),
            topLeft: Radius.circular(LemonRadius.extraSmall),
            topRight: Radius.circular(LemonRadius.extraSmall),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: event.approvalRequired == true
                  ? Assets.icons.icError.svg(
                      width: 18.w,
                      height: 18.w,
                    )
                  : Assets.icons.icGuestsGradient.svg(
                      width: 18.w,
                      height: 18.w,
                    ),
            ),
            SizedBox(width: Spacing.extraSmall),
            Text(
              event.approvalRequired == true
                  ? t.event.eventApproval.pendingRequests(
                      count: event.pendingRequestCount?.toString() ?? 0,
                      n: event.pendingRequestCount ?? 0,
                    )
                  : t.event.eventApproval.guests,
              style: Typo.medium.copyWith(
                color: colorScheme.onSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icArrowRight.svg(
                width: 18.w,
                height: 18.w,
                colorFilter: filter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditEventButton extends StatelessWidget {
  const _EditEventButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: Spacing.smMedium,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.06),
              borderRadius: BorderRadius.all(Radius.circular(9.r)),
            ),
            width: Sizing.medium,
            height: Sizing.medium,
            child: InkWell(
              onTap: () {
                Vibrate.feedback(FeedbackType.light);
                AutoRouter.of(context).navigate(const EventControlPanelRoute());
              },
              child: Center(
                child: ThemeSvgIcon(
                  color: colorScheme.onSecondary,
                  builder: (filter) => Assets.icons.icEdit.svg(
                    colorFilter: filter,
                    width: 15.w,
                    height: 15.w,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
