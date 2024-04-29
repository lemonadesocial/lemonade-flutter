import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/presentation/pages/collaborator/widgets/spotline_event_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorDiscoverSpotlightEventsSection extends StatelessWidget {
  const CollaboratorDiscoverSpotlightEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final events = [
      Event(
        title: "Living room gig gigachad nomad",
        start: DateTime.now(),
      ),
      Event(
        title: "Early morning yoga",
        start: DateTime.now(),
      ),
      Event(
        title: "Secret room",
        start: DateTime.now(),
      ),
    ];
    if (events.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: LemonColor.white06,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LemonRadius.normal),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: ThemeSvgIcon(
                      color: LemonColor.paleViolet,
                      builder: (colorFilter) => Assets.icons.icHouseParty.svg(
                        colorFilter: colorFilter,
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.smMedium / 2),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        t.collaborator.spotlightEvents,
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Spacing.smMedium),
            SizedBox(
              height: 128.w,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: Spacing.smMedium / 2,
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (BuildContext context, int index) {
                  return SpotlineEventItem(
                    event: events[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
