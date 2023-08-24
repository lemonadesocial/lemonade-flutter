import 'package:app/core/presentation/widgets/common/appbar/appbar_logo.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/discover/discover_card.dart';
import 'package:app/core/presentation/widgets/event/event_discover_item.dart';
import 'package:app/core/presentation/widgets/poap/hot_badge_item.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: LemonAppBar(
        title: t.discover.discover,
        leading: const AppBarLogo(),
        actions: [
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).navigate(const ChatListRoute());
            },
            child: ThemeSvgIcon(
              color: Theme.of(context).colorScheme.onSurface,
              builder: (filter) => Assets.icons.icChatBubble.svg(
                colorFilter: filter,
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            sliver: const _DiscoverCards(),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
          ),
          const _HotBadgesNearYou(),
          const _UpcomingEvents(),
          SliverPadding(
            padding: EdgeInsets.only(top: Spacing.medium),
          ),
        ],
      ),
    );
  }
}


class _UpcomingEvents extends StatelessWidget {
  const _UpcomingEvents();

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

class _HotBadgesNearYou extends StatelessWidget {
  const _HotBadgesNearYou();

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
              t.discover.hotBadgesNearYou,
              style: Typo.medium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 226.w,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const HotBadgeItem(),
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

class _DiscoverCards extends StatelessWidget {
  const _DiscoverCards();
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
