import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/event_approval_setting_page.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/graphql/backend/event/query/export_event_tickets.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
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
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:slang/builder/utils/string_extensions.dart';

class HostEventBasicInfoCard extends StatelessWidget {
  const HostEventBasicInfoCard({
    super.key,
    required this.event,
    this.registrationCount,
    // required this.eventUserRole,
  });

  final Event event;
  final double? registrationCount;
  // final EventUserRole? eventUserRole;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final relayPaymentSupported = event.paymentAccountsExpanded?.any(
          (element) => element.type == PaymentAccountType.ethereumRelay,
        ) ??
        false;
    final (formattedDate, formattedTime) =
        EventUtils.getFormattedEventDateAndTime(event);
    // final canShowGuestList = FeatureManager(
    //   EventRoleBasedEventFeatureVisibilityStrategy(
    //     eventUserRole: eventUserRole,
    //     featureCodes: [Enum$FeatureCode.GuestListDashboard],
    //   ),
    // ).canShowFeature;
    // final canShowEventSettings = FeatureManager(
    //   EventRoleBasedEventFeatureVisibilityStrategy(
    //     eventUserRole: eventUserRole,
    //     featureCodes: [Enum$FeatureCode.EventSettings],
    //   ),
    // ).canShowFeature;

    return Column(
      children: [
        Container(
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
                          padding: EdgeInsets.only(
                            top: Spacing.smMedium,
                            bottom: Spacing.smMedium,
                            left: Spacing.smMedium,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.title ?? '',
                                      style: Typo.small.copyWith(
                                        color: colorScheme.onSecondary,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: FontFamily.switzerVariable,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      EventUtils.getDurationToEventText(
                                            event,
                                          ) ??
                                          '',
                                      style: Typo.mediumPlus.copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontFamily.nohemiVariable,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      formattedDate,
                                      style: Typo.small.copyWith(
                                        color: colorScheme.onSecondary,
                                        height: 0,
                                      ),
                                    ),
                                    Text(
                                      formattedTime,
                                      style: Typo.small.copyWith(
                                        color: colorScheme.onSecondary,
                                        height: 0,
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
                  // if (canShowEventSettings)
                  const _EditEventButton(),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: Spacing.extraSmall,
        ),
        // if (canShowGuestList)
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
                        Query$ExportEventTickets$Widget(
                          options: Options$Query$ExportEventTickets(
                            fetchPolicy: FetchPolicy.networkOnly,
                            variables: Variables$Query$ExportEventTickets(
                              id: event.id ?? '',
                              pagination: Input$PaginationInput(
                                limit: 1,
                                skip: 0,
                              ),
                            ),
                          ),
                          builder: (result, {refetch, fetchMore}) {
                            if (result.isLoading) {
                              return Text(
                                '--',
                                style: Typo.mediumPlus.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontFamily: FontFamily.nohemiVariable,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            final registrationCount =
                                result.parsedData?.exportEventTickets.count;
                            return Text(
                              registrationCount?.toStringAsFixed(0) ??
                                  event.attendingCount
                                      ?.toString() ?? // fallback for old events data
                                  '',
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onPrimary,
                                fontFamily: FontFamily.nohemiVariable,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          t.event.registration.capitalize(),
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
        // if (canShowGuestList)
        SizedBox(
          height: Spacing.extraSmall,
        ),
        if (relayPaymentSupported) ...[
          _ClaimRelayPaymentButton(event: event),
          SizedBox(
            height: Spacing.extraSmall,
          ),
        ],
        // if (canShowGuestList)
        _ViewGuestsButton(event: event),
      ],
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
