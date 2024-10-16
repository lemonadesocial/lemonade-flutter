import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/guest_event_detail_page/widgets/guest_event_detail_expand_button.dart';
import 'package:app/core/presentation/pages/event/sub_events_listing_page/views/sub_events_listing_list_view/widgets/sub_event_list_view_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventDetailSubEvents extends StatelessWidget {
  final Event event;
  final List<Event> subEvents;
  const GuestEventDetailSubEvents({
    super.key,
    required this.event,
    required this.subEvents,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final mSubEvents = subEvents.take(3).toList();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.smMedium,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.event.subEvent.subEvents,
                style: Typo.extraMedium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const GuestEventDetailExpandButton(),
            ],
          ),
          SizedBox(height: Spacing.smMedium),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: mSubEvents.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: Spacing.xSmall);
            },
            itemBuilder: (context, index) {
              return SubEventListViewItem(event: mSubEvents[index]);
            },
          ),
          SizedBox(height: Spacing.smMedium),
          InkWell(
            onTap: () {
              AutoRouter.of(context)
                  .push(SubEventsListingRoute(parentEventId: event.id ?? ''));
            },
            child: Container(
              padding: EdgeInsets.all(Spacing.small),
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                borderRadius: BorderRadius.circular(LemonRadius.medium),
                border: Border.all(
                  color: colorScheme.outlineVariant,
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.common.actions.viewAll,
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icArrowRight.svg(
                      colorFilter: filter,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
