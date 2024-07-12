import 'package:app/core/presentation/pages/home/views/list/home_newsfeed_list.dart';
import 'package:app/core/presentation/pages/home/widgets/quest_points_widget.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar_default_more_actions_widget.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final isLoggedIn = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => false,
          authenticated: (_) => true,
        );
    return Scaffold(
      appBar: HomeAppBar(
        title: t.home.newsfeed,
        actions: [
          if (!isLoggedIn) ...[
            SizedBox(
              width: 85.w,
              child: LemonOutlineButton(
                onTap: () {
                  AutoRouter.of(context).navigate(const LoginRoute());
                },
                label: t.auth.signIn,
                backgroundColor: colorScheme.secondaryContainer,
                borderColor: colorScheme.secondaryContainer,
                radius: BorderRadius.circular(LemonRadius.button),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
          ],
          if (isLoggedIn) ...[
            const QuestPointsWidget(),
            SizedBox(width: Spacing.medium),
            InkWell(
              onTap: () {
                AutoRouter.of(context).navigate(MyEventTicketsListRoute());
              },
              child: ThemeSvgIcon(
                builder: (filter) => Assets.icons.icTicket.svg(
                  colorFilter: filter,
                ),
              ),
            ),
            SizedBox(width: Spacing.medium),
            Padding(
              padding: EdgeInsets.only(right: Spacing.xSmall),
              child: const HomeAppBarDefaultMoreActionsWidget(),
            ),
          ],
        ],
      ),
      backgroundColor: LemonColor.black,
      body: const HomeNewsfeedListView(),
    );
  }
}
