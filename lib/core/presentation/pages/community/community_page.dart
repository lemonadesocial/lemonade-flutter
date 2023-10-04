import 'package:app/core/presentation/pages/community/widgets/community_friend_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/tabbar_indicator/custom_tabbar_indicator.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/theme.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return MaterialApp(
      theme: lemonadeAppDarkThemeData,
      home: DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: Scaffold(
          backgroundColor: colorScheme.primary,
          appBar: LemonAppBar(
            title: t.setting.community,
          ),
          body: Column(
            children: [
              TabBar(
                isScrollable: true,
                labelStyle: Typo.medium.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
                unselectedLabelStyle: Typo.medium.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.36),
                  fontWeight: FontWeight.w500,
                ),
                indicator: CustomTabIndicator(color: LemonColor.paleViolet),
                indicatorPadding:
                    EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                tabs: <Widget>[
                  Tab(text: t.setting.friend),
                  Tab(text: t.setting.follower),
                  Tab(text: t.setting.friend),
                  Tab(text: t.setting.friend),
                ],
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  CommunityFriendView(),
                  CommunityFriendView(),
                  CommunityFriendView(),
                  CommunityFriendView()
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
