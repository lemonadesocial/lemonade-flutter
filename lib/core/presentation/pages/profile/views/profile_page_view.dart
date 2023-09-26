import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_collectible_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_event_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_info_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_photos_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_posts_tab_view.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_page_header_widget.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_tabbar_delegate_widget.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/profile_animated_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/drawer/lemon_drawer.dart';
import 'package:app/core/presentation/widgets/common/sliver/dynamic_sliver_appbar.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:sliver_tools/sliver_tools.dart';

final drawerKey = GlobalKey<SliderDrawerState>();

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView>
    with TickerProviderStateMixin {
  late final controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(controller);

  bool isDrawerOpen = false;

  int get _tabCount => 5;

  late final TabController _tabCtrl = TabController(
    length: _tabCount,
    vsync: this,
    initialIndex: 0,
  );

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return state.when(
          fetched: (userProfile) {
            final isMe = AuthUtils.isMe(context, user: userProfile);
            final profileTitle =
                '@${userProfile.username ?? t.common.anonymous}';
            return SliderDrawer(
              key: drawerKey,
              slider: LemonDrawer(user: userProfile),
              splashColor: colorScheme.primary,
              appBar: null,
              child: Scaffold(
                backgroundColor: colorScheme.primary,
                body: SafeArea(
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                        sliver: MultiSliver(
                          children: [
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: ProfileAnimatedAppBar(
                                title: profileTitle,
                                leading: isMe
                                    ? appBarLeading()
                                    : const LemonBackButton(),
                                actions: [appBarTrailing(isMe, colorScheme)],
                              ),
                            ),
                            DynamicSliverAppBar(
                              maxHeight: 250.h,
                              floating: true,
                              forceElevated: innerBoxIsScrolled,
                              child: ProfilePageHeader(user: userProfile),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              delegate:
                                  ProfileTabBarDelegate(controller: _tabCtrl),
                            ),
                          ],
                        ),
                      ),
                    ],
                    body: Scaffold(
                      backgroundColor: colorScheme.primary,
                      body: SafeArea(
                        child: TabBarView(
                          controller: _tabCtrl,
                          children: [
                            ProfilePostsTabView(user: userProfile),
                            ProfileCollectibleTabView(user: userProfile),
                            ProfileEventTabView(user: userProfile),
                            ProfilePhotosTabView(user: userProfile),
                            // EmptyTabView(),
                            ProfileInfoTabView(user: userProfile),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          failure: () => Center(
            child: Text(t.common.somethingWrong),
          ),
          loading: () => Center(
            child: Loading.defaultLoading(context),
          ),
        );
      },
    );
  }

  Widget appBarLeading() {
    return InkWell(
      onTap: () {
        if (isDrawerOpen) {
          controller.reverse();
          drawerKey.currentState!.closeSlider();
        } else {
          controller.forward();
          drawerKey.currentState!.openSlider();
        }
        isDrawerOpen = !isDrawerOpen;
      },
      child: Align(
        alignment: Alignment.center,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: animation,
        ),
      ),
    );
  }

  Widget appBarTrailing(bool isMe, ColorScheme colorScheme) {
    return isMe
        ? InkWell(
            onTap: () {
              context.read<AuthBloc>().state.maybeWhen(
                    authenticated: (session) =>
                        AutoRouter.of(context).navigate(const ChatListRoute()),
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
          )
        : GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {},
            child: ThemeSvgIcon(
              color: colorScheme.onPrimary,
              builder: (filter) =>
                  Assets.icons.icMoreHoriz.svg(colorFilter: filter),
            ),
          );
  }
}
