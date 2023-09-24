import 'package:app/core/presentation/widgets/discover/discover_card.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverCards extends StatelessWidget {
  const DiscoverCards({super.key});

  void alertComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text('Coming soon'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final t = Translations.of(context);
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 9.w,
      childAspectRatio: (0.9),
      children: [
        DiscoverCard(
          title: t.discover.cardSections.events.title,
          subTitle: t.discover.cardSections.events.subTitle,
          icon: Assets.icons.icDiscoverEvents.svg(),
          colors: DiscoverCardGradient.events.colors,
          onTap: () => router.navigateNamed('/events'),
        ),
        DiscoverCard(
          title: t.discover.cardSections.collaborators.title,
          subTitle: t.discover.cardSections.collaborators.subTitle,
          icon: Assets.icons.icDiscoverPeople.svg(),
          colors: DiscoverCardGradient.collaborators.colors,
          onTap: () {
            alertComingSoon(context);
          },
        ),
        DiscoverCard(
          title: t.discover.cardSections.badges.title,
          subTitle: t.discover.cardSections.badges.subTitle,
          icon: Assets.icons.icDiscoverBadges.svg(),
          colors: DiscoverCardGradient.badges.colors,
          onTap: () => router.navigateNamed('/poap'),
        ),
      ],
    );
  }
}
