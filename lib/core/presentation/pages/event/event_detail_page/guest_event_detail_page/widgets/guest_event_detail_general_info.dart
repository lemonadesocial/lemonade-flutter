import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_invite.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_about.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_rsvp_status/guest_event_detail_rsvp_status.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_hosts_avatars.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_pending_invites_widget/guest_event_pending_invites_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:app/app_theme/app_theme.dart';

class GuestEventDetailGeneralInfo extends StatelessWidget {
  const GuestEventDetailGeneralInfo({
    super.key,
    required this.event,
    this.pendingCohostRequest,
  });
  final Event event;
  final EventInvite? pendingCohostRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (pendingCohostRequest != null) ...[
          const GuestEventCohostRequestWidget(),
          SizedBox(height: Spacing.xSmall),
        ],
        if (event.approvalRequired == true ||
            event.guestLimit != null ||
            event.registrationDisabled == true) ...[
          GuestEventDetailRSVPStatus(
            event: event,
          ),
          SizedBox(height: Spacing.xSmall),
        ],
        _InfoCard(event: event),
        if (event.description != null && event.description!.isNotEmpty) ...[
          SizedBox(
            height: Spacing.smMedium,
          ),
          GuestEventDetailAbout(
            event: event,
            showTitle: false,
          ),
        ],
        // CastOnFarcasterButton(event: event),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Event event;
  const _InfoCard({
    required this.event,
  });

  String get hostNames {
    final hosts = EventUtils.getVisibleCohosts(event);
    if (hosts.isEmpty) return '';
    final firstHost = hosts.firstOrNull;
    final remainingHosts = hosts.skip(1).toList();
    return '${(firstHost?.name ?? '')} ${remainingHosts.isNotEmpty ? ' +${remainingHosts.length}' : ''}';
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final (formattedDate, formattedTime) =
        EventUtils.getFormattedEventDateAndTime(event);
    final wigets = [
      Padding(
        padding: EdgeInsets.all(
          Spacing.small,
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icCalendarClockOutline.svg(
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.small),
            Flexible(
              child: Text(
                '$formattedDate, $formattedTime',
                style: appText.md,
              ),
            ),
          ],
        ),
      ),
      if (event.address != null)
        Padding(
          padding: EdgeInsets.all(Spacing.small),
          child: Row(
            children: [
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icLocationPin.svg(
                  colorFilter: filter,
                ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      EventUtils.getAddress(
                        event: event,
                        showFullAddress: false,
                        isAttending: false,
                        isOwnEvent: false,
                      ),
                      style: appText.md,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      if (EventUtils.getVisibleCohosts(event).isNotEmpty)
        Padding(
          padding: EdgeInsets.all(Spacing.small),
          child: Row(
            children: [
              ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icHostOutline.svg(
                  colorFilter: filter,
                ),
              ),
              SizedBox(width: Spacing.small),
              Expanded(
                child: Text(
                  hostNames,
                  style: appText.md,
                ),
              ),
              GuestEventHostsAvatars(event: event),
            ],
          ),
        ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appColors.cardBg,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          color: appColors.cardBorder,
          width: 1.w,
        ),
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => wigets[index],
        separatorBuilder: (context, index) => Divider(
          height: 1.w,
          thickness: 1.w,
          color: appColors.pageDivider,
        ),
        itemCount: wigets.length,
      ),
    );
  }
}
