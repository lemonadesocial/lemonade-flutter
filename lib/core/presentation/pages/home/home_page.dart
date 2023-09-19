import 'package:app/core/presentation/pages/home/views/list/home_newsfeed_list.dart';
import 'package:app/core/presentation/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/appbar_logo.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/home/floating_create_button.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/shake/shake_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  void initState() {
    super.initState();
    getIt<ShakeService>().startShakeDetection(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: LemonAppBar(
        title: t.home.newsfeed,
        leading: const AppBarLogo(),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.read<AuthBloc>().state.maybeWhen(
                    authenticated: (session) =>
                        AutoRouter.of(context).navigate(const ChatListRoute()),
                    orElse: () =>
                        AutoRouter.of(context).navigate(const LoginRoute()),
                  );
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
      backgroundColor: LemonColor.black,
      body: const HomeNewsfeedListView(),
      floatingActionButton: userId == null
          ? null
          : Padding(
              padding: EdgeInsets.only(bottom: BottomBar.bottomBarHeight),
              child: FloatingCreateButton(
                // onTap: () => context.router.push(
                //   CreatePostRoute(
                //     onPostCreated: (newPost) =>
                //         context.read<NewsfeedListingBloc>().add(
                //               NewsfeedListingEvent.newPostAdded(post: newPost),
                //             ),
                //   ),
                // ),
                onTap: () {
                  AutoRouter.of(context).navigate(
                    const EventBuyTicketsRoute(),
                  );
                },
              ),
            ),
    );
  }
}
