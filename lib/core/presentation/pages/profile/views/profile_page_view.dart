import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_posts_tab_view.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_page_header_widget.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_tabbar_delegate_widget.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_collectible_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_event_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_info_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_photos_tab_view.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/burger_menu_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/appbar_logo.dart';
import 'package:app/core/presentation/widgets/common/appbar/profile_animated_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/sliver/dynamic_sliver_appbar.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfilePageView extends StatefulWidget {
  final String userId;
  const ProfilePageView({
    super.key,
    required this.userId,
  });

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> with SingleTickerProviderStateMixin {
  int get _tabCount => 5;

  late final TabController _tabCtrl = TabController(
    length: _tabCount,
    vsync: this,
    initialIndex: 0,
  );

  @override
  void initState() {
    super.initState();
  }

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
            return Scaffold(
              backgroundColor: colorScheme.primary,
              body: SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      sliver: MultiSliver(
                        children: [
                          SliverPersistentHeader(
                              pinned: true,
                              floating: false,
                              delegate: ProfileAnimatedAppBar(
                                title: '@${userProfile.username ?? t.common.anonymous}',
                                leading: isMe ? AppBarLogo() : LemonBackButton(),
                                actions: [
                                  if(isMe) FloatingFrostedGlassDropdown(
                                    items: [
                                      DropdownItemDpo(
                                        label: t.auth.logout,
                                      ),
                                    ],
                                    onItemPressed: (item) {
                                      context.read<AuthBloc>().add(AuthEvent.logout());
                                    },
                                    child: BurgerMenu(),
                                  ),
                                  if(!isMe) GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {},
                                    child: Container(
                                      // color: Colors.rtraed,
                                      child: ThemeSvgIcon(
                                        color: colorScheme.onPrimary,
                                        builder: (filter) => Assets.icons.icMoreHoriz.svg(colorFilter: filter),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          DynamicSliverAppBar(
                            child: ProfilePageHeader(user: userProfile),
                            maxHeight: 250,
                            floating: true,
                            forceElevated: innerBoxIsScrolled,
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            floating: false,
                            delegate: ProfileTabBarDelegate(controller: _tabCtrl),
                          ),
                        ],
                      ),
                    ),
                  ],
                  body: TabBarView(
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
}
