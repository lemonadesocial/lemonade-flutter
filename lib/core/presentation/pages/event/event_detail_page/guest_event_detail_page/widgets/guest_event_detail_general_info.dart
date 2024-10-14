import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_about.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_rsvp_status/guest_event_detail_rsvp_status.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_hosts_avatars.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailGeneralInfo extends StatelessWidget {
  const GuestEventDetailGeneralInfo({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _HostInfo(event: event),
        SizedBox(
          height: Spacing.superExtraSmall,
        ),
        Text(
          event.title ?? '',
          style: Typo.superLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
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

class _HostInfo extends StatelessWidget {
  const _HostInfo({
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          ProfileRoute(
            userId: event.hostExpanded?.userId ?? '',
          ),
        );
      },
      child: Row(
        children: [
          LemonNetworkImage(
            imageUrl: event.hostExpanded?.imageAvatar ?? '',
            width: 18.w,
            height: 18.w,
            borderRadius: BorderRadius.circular(18.w),
            placeholder: ImagePlaceholder.avatarPlaceholder(),
          ),
          SizedBox(width: Spacing.extraSmall),
          Text(
            (event.hostExpanded?.name ?? '').toUpperCase(),
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(width: Spacing.superExtraSmall),
          ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icArrowRight.svg(
              colorFilter: filter,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Event event;
  const _InfoCard({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final formattedStartDate = DateFormatUtils.dateWithTimezone(
      dateTime: event.start ?? DateTime.now(),
      timezone: event.timezone ?? '',
      pattern: 'MMM d, hh:mm a',
    );
    final formattedEndDate = DateFormatUtils.dateWithTimezone(
      dateTime: event.end ?? DateTime.now(),
      timezone: event.timezone ?? '',
      pattern: 'MMM d, hh:mm a',
    );
    final wigets = [
      Padding(
        padding: EdgeInsets.all(
          Spacing.small,
        ),
        child: Row(
          children: [
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (filter) => Assets.icons.icCalendar.svg(
                colorFilter: filter,
              ),
            ),
            SizedBox(width: Spacing.small),
            Flexible(
              child: Text(
                '$formattedStartDate - $formattedEndDate',
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
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
              Flexible(
                child: Text(
                  event.address?.title ?? '',
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
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
                '${(event.hostExpanded?.name ?? '')} ${event.cohostsExpanded?.isNotEmpty == true ? ' +${event.cohostsExpanded?.length}' : ''}'
                    .toUpperCase(),
                style: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
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
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
        border: Border.all(
          color: colorScheme.outline,
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
          color: colorScheme.outline,
        ),
        itemCount: wigets.length,
      ),
    );
  }
}
