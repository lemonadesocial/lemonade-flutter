import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/widgets/sub_events_empty_widget.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/core/utils/event_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubEventsListingRegularView extends StatelessWidget {
  final bool isCalendarShowing;
  final void Function(ScrollMetrics metrics)? onScroll;
  final List<Event> events;
  const SubEventsListingRegularView({
    super.key,
    required this.events,
    this.isCalendarShowing = false,
    this.onScroll,
  });

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Expanded(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: Spacing.small),
              sliver: const SliverToBoxAdapter(
                child: SubEventsEmptyWidget(),
              ),
            ),
          ],
        ),
      );
    }
    return Expanded(
      child: Column(
        children: [
          if (isCalendarShowing) SizedBox(height: Spacing.xSmall),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Spacing.xSmall,
              ),
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    onScroll?.call(notification.metrics);
                  }
                  return true;
                },
                child: CustomScrollView(
                  slivers: [
                    SliverList.separated(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return _EventItem(event: events[index]);
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: Spacing.xSmall),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final Event event;
  const _EventItem({
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(EventDetailRoute(eventId: event.id ?? ''));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LemonRadius.medium),
          color: LemonColor.atomicBlack,
        ),
        padding: EdgeInsets.all(Spacing.medium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: Spacing.xSmall),
                  _Tile(
                    icon: LemonNetworkImage(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      imageUrl: event.hostExpanded?.imageAvatar ?? "",
                      borderRadius: BorderRadius.circular(Sizing.xSmall),
                      placeholder: ImagePlaceholder.avatarPlaceholder(),
                    ),
                    title:
                        '${t.event.hostedBy} ${event.hostExpanded?.name ?? ""}',
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  _Tile(
                    icon: Icon(
                      Icons.today_outlined,
                      size: 15.w,
                      color: colorScheme.onSecondary,
                    ),
                    title: DateFormatUtils.fullDateWithTime(
                      event.start ?? DateTime.now(),
                    ),
                  ),
                  if (event.address != null) ...[
                    SizedBox(height: Spacing.superExtraSmall),
                    _Tile(
                      icon: Assets.icons.icLocationPin.svg(
                        color: colorScheme.onSecondary,
                      ),
                      title: event.address?.city ?? '',
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: Spacing.medium),
            LemonNetworkImage(
              imageUrl: EventUtils.getEventThumbnailUrl(event: event),
              width: 90.w,
              height: 90.w,
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              placeholder: ImagePlaceholder.eventCard(),
              border: Border.all(
                color: colorScheme.outline,
                width: 1.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final Widget icon;
  final String title;
  const _Tile({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        icon,
        SizedBox(width: Spacing.superExtraSmall),
        Flexible(
          child: Text(
            title,
            style: Typo.small.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
