import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/pages/collaborator/widgets/spotlight_event_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollaboratorDiscoverSpotlightEventsSection extends StatelessWidget {
  final User? user;
  const CollaboratorDiscoverSpotlightEventsSection({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final events = user?.eventsExpanded ?? [];
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    if (events.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: appColors.cardBg,
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
                        style: appText.md,
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
                  return InkWell(
                    onTap: () {
                      AutoRouter.of(context).push(
                        EventDetailRoute(eventId: events[index].id ?? ''),
                      );
                    },
                    child: SpotlightEventItem(
                      event: events[index],
                    ),
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
