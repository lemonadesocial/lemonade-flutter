import 'package:app/core/presentation/widgets/event/event_discover_item.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

class DiscoverUpcomingEvents extends StatelessWidget {
  const DiscoverUpcomingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return MultiSliver(
      children: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: Spacing.xSmall,
            horizontal: Spacing.xSmall,
          ),
          sliver: SliverToBoxAdapter(
            child: Text(
              t.discover.upcomingEvents,
              style: Typo.medium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 160.w,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const EventDiscoverItem(),
              separatorBuilder: (context, index) => SizedBox(
                width: Spacing.xSmall,
              ),
              itemCount: 5,
            ),
          ),
        ),
      ],
    );
  }
}
