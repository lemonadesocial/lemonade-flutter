import 'package:app/core/presentation/pages/discover/discover_page/views/discover_badges_near_you.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_cards.dart';
import 'package:app/core/presentation/pages/discover/discover_page/views/discover_upcoming_events.dart';
import 'package:app/core/presentation/widgets/common/appbar/appbar_logo.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            behavior: HitTestBehavior.translucent,
            onTap: () {
              AutoRouter.of(context).navigate(const ChatListRoute());
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              alignment: Alignment.centerRight,
              child: ThemeSvgIcon(
                color: Theme.of(context).colorScheme.onSurface,
                builder: (filter) => Assets.icons.icChatBubble.svg(
                  colorFilter: filter,
                ),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            sliver: const DiscoverCards(),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: Spacing.xSmall),
          ),
          const DiscoverBadgesNearYou(),
          const DiscoverUpcomingEvents(),
          SliverPadding(
            padding: EdgeInsets.only(top: Spacing.medium),
          ),
        ],
      ),
    );
  }
}
