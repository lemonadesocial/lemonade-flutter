import 'package:app/core/presentation/widgets/discover/discover_card.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverCards extends StatelessWidget {
  const DiscoverCards({super.key});
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return SliverGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 9.w,
      crossAxisSpacing: 9.w,
      childAspectRatio: 1.3,
      children: [
        DiscoverCard(
          title: t.discover.cardSections.events.title,
          subTitle: t.discover.cardSections.events.subTitle,
          icon: Assets.icons.icDiscoverEvents.svg(),
          colors: DiscoverCardGradient.events.colors,
        ),
        DiscoverCard(
          title: t.discover.cardSections.collaborators.title,
          subTitle: t.discover.cardSections.collaborators.subTitle,
          icon: Assets.icons.icDiscoverPeople.svg(),
          colors: DiscoverCardGradient.collaborators.colors,
        ),
        DiscoverCard(
          title: t.discover.cardSections.badges.title,
          subTitle: t.discover.cardSections.badges.subTitle,
          icon: Assets.icons.icDiscoverBadges.svg(),
          colors: DiscoverCardGradient.badges.colors,
        ),
        DiscoverCard(
          title: t.discover.cardSections.music.title,
          subTitle: t.discover.cardSections.music.subTitle,
          icon: Assets.icons.icDiscoverMusic.svg(),
          colors: DiscoverCardGradient.music.colors,
        ),
      ],
    );
  }
}
