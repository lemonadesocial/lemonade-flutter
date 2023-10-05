import 'package:app/core/presentation/pages/home/views/list/home_newsfeed_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/shake/shake_service.dart';
import 'package:app/core/utils/drawer_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/core/utils/swipe_detector.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/core/application/auth/auth_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userId = getIt<AuthBloc>().state.maybeWhen(
        authenticated: (authSession) => authSession.userId,
        orElse: () => null,
      );
  late Offset startGlobalPosition;

  @override
  void initState() {
    super.initState();
    getIt<ShakeService>().startShakeDetection(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: LemonAppBar(
          title: t.home.newsfeed,
          leading: InkWell(
            onTap: () => DrawerUtils.openDrawer(),
            child: Icon(
              Icons.menu_outlined,
              color: colorScheme.onPrimary,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Spacing.xSmall),
              child: InkWell(
                onTap: () {
                  context.read<AuthBloc>().state.maybeWhen(
                        authenticated: (session) => AutoRouter.of(context)
                            .navigate(const ChatListRoute()),
                        orElse: () =>
                            AutoRouter.of(context).navigate(const LoginRoute()),
                      );
                },
                child: ThemeSvgIcon(
                  color: colorScheme.onPrimary,
                  builder: (filter) => Assets.icons.icChatBubble.svg(
                    colorFilter: filter,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: LemonColor.black,
        body: SwipeDetector(
          child: const HomeNewsfeedListView(),
          onSwipeUp: () {},
          onSwipeDown: () {},
          onSwipeLeft: () {
            context.read<AuthBloc>().state.maybeWhen(
                  authenticated: (session) =>
                      AutoRouter.of(context).navigate(const ChatListRoute()),
                  orElse: () =>
                      AutoRouter.of(context).navigate(const LoginRoute()),
                );
          },
          onSwipeRight: () {},
        ),
      ),
    );
  }
}
