import 'package:app/core/presentation/widgets/burger_menu_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/separator/horizontal_line.dart';
import 'package:app/core/presentation/widgets/home/what_on_your_mind_input.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/shake/shake_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getIt<ShakeService>().startShakeDetection(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: LemonAppBar(
        title: t.home.newsfeed,
        leading: BurgerMenu(),
        actions: [
          GestureDetector(
            onTap: () {
              AutoRouter.of(context).navigateNamed('/chat');
            },
            child: ThemeSvgIcon(
              color: themeColor.onSurface,
              builder: (filter) => Assets.icons.icChat.svg(
                colorFilter: filter,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: LemonColor.black,
      body: Container(
        child: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small),
            child: WhatOnYourMindInput(),
          ),
          SizedBox(height: Spacing.smMedium),
          HorizontalLine(),
          ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).navigate(PoapListingRoute());
            },
            child: Text("Navigate to poap"),
          ),
          ElevatedButton(
            onPressed: () {
              AutoRouter.of(context).navigate(ChatListRoute());
            },
            child: Text("Navigate to Chat"),
          )
        ]),
      ),
      // body: ,
    );
  }
}
