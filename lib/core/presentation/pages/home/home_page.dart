import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/presentation/pages/auth/login_page.dart';
import 'package:app/core/presentation/pages/home/views/home_view.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar_default_more_actions_widget.dart';
import 'package:app/core/presentation/widgets/home_appbar/home_appbar.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isLoggedIn = context.read<AuthBloc>().state.maybeWhen(
            orElse: () => false,
            authenticated: (_) => true,
          );
      if (!isLoggedIn) {
        AutoRouter.of(context).navigate(DiscoverRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final appColors = Theme.of(context).appColors;
    final isLoggedIn = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => false,
          authenticated: (_) => true,
        );
    final isProcessingLogin = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => false,
          processing: () => true,
        );

    if (!isLoggedIn || isProcessingLogin) {
      return const LoginPage(
        isHomeScreen: true,
      );
    }

    return Scaffold(
      appBar: HomeAppBar(
        title: "",
        backgroundColor: appColors.pageBg,
        actions: [
          if (isProcessingLogin) ...[
            Loading.defaultLoading(context),
            SizedBox(width: Spacing.xSmall),
          ],
          if (!isLoggedIn && !isProcessingLogin) ...[
            SizedBox(
              width: 85.w,
              child: LemonOutlineButton(
                onTap: () {
                  AutoRouter.of(context).navigate(LoginRoute());
                },
                label: t.auth.signIn,
                backgroundColor: appColors.buttonSecondary,
                borderColor: appColors.cardBorder,
                radius: BorderRadius.circular(LemonRadius.button),
              ),
            ),
            SizedBox(width: Spacing.xSmall),
          ],
          if (isLoggedIn) ...[
            const HomeAppBarNotificationAction(),
            SizedBox(width: Spacing.s5),
            Padding(
              padding: EdgeInsets.only(right: Spacing.xSmall),
              child: const HomeAppBarDefaultMoreActionsWidget(),
            ),
          ],
        ],
      ),
      backgroundColor: appColors.pageBg,
      body: const HomeView(),
      // body: Positioned(
      //   right: Spacing.s4,
      //   bottom: BottomBar.bottomBarHeight + Spacing.s14,
      //   child: LensAddPostsButton(
      //     lensFeedId: AppConfig.lemonadeGlobalFeed,
      //     builder: (context, lensAuthState, onTapCreatePost) {
      //       return FloatingActionButton(
      //         shape: const CircleBorder(),
      //         backgroundColor: appColors.buttonSecondaryBg,
      //         onPressed: () {
      //           onTapCreatePost(lensAuthState);
      //         },
      //         child: ThemeSvgIcon(
      //           color: appColors.buttonSecondary,
      //           builder: (filter) =>
      //               Assets.icons.icEditSquareOutlineSharp.svg(
      //             colorFilter: filter,
      //             width: Sizing.s6,
      //             height: Sizing.s6,
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
