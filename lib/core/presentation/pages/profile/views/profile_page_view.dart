import 'package:app/core/application/event/events_listing_bloc/events_listing_bloc.dart';
import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_page_header_widget.dart';
import 'package:app/core/presentation/pages/profile/widgets/profile_tabbar_delegate_widget.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/empty_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_collectible_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_event_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_info_tab_view.dart';
import 'package:app/core/presentation/pages/profile/views/tabs/profile_photos_tab_view.dart';
import 'package:app/core/presentation/widgets/burger_menu_widget.dart';
import 'package:app/core/presentation/widgets/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  double get _headerHeight => 230;

  int get _tabCount => 6;

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
            return Scaffold(
              backgroundColor: colorScheme.primary,
              appBar: LemonAppBar(
                title: '@${userProfile.username ?? t.common.anonymous}',
                leading: BurgerMenu(),
                actions: [
                  ThemeSvgIcon(
                    color: colorScheme.onSurface,
                    builder: (filter) => Assets.icons.icShare.svg(colorFilter: filter),
                  ),
                  ThemeSvgIcon(
                    color: colorScheme.onSurface,
                    builder: (filter) => Assets.icons.icMoreHoriz.svg(colorFilter: filter),
                  ),
                ],
              ),
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    floating: true,
                    expandedHeight: _headerHeight,
                    collapsedHeight: _headerHeight,
                    flexibleSpace: ProfilePageHeader(
                      user: userProfile,
                    ),
                    forceElevated: innerBoxIsScrolled,
                  ),
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverPersistentHeader(
                      pinned: true,
                      floating: false,
                      delegate: ProfileTabBarDelegate(controller: _tabCtrl),
                    ),
                  ),
                ],
                body: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => EventsListingBloc(
                        EventService(getIt<EventRepository>()),
                      ),
                    ),
                  ],
                  child: TabBarView(
                    controller: _tabCtrl,
                    children: [
                      EmptyTabView(),
                      ProfileCollectibleTabView(user: userProfile),
                      ProfileEventTabView(user: userProfile),
                      ProfilePhotosTabView(user: userProfile),
                      EmptyTabView(),
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
