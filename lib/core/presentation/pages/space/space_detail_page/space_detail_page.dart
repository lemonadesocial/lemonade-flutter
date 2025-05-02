import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/application/space/follow_space_bloc/follow_space_bloc.dart';
import 'package:app/core/application/space/get_my_space_event_requests_bloc/get_my_space_event_requests_bloc.dart';
import 'package:app/core/application/space/get_space_detail_bloc/get_space_detail_bloc.dart';
import 'package:app/core/application/space/get_space_event_requests_bloc/get_space_event_requests_bloc.dart';
import 'package:app/core/application/space/get_space_events_bloc/get_space_events_bloc.dart';
import 'package:app/core/domain/space/entities/space_event_request.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_add_posts_button/lens_add_posts_button.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/lens_post_feed_widget.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_event_requests_admin_list.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_events_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/event/query/get_events.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/graphql/backend/space/query/get_space_event_requests.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_header.dart';
import 'package:app/core/presentation/pages/space/space_detail_page/widgets/space_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class SpaceDetailPage extends StatelessWidget {
  final String spaceId;
  const SpaceDetailPage({
    super.key,
    required this.spaceId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScrollNotificationBloc(),
        ),
        BlocProvider(
          create: (context) => GetSpaceDetailBloc(getIt<SpaceRepository>())
            ..add(
              GetSpaceDetailEvent.fetch(
                spaceId: spaceId,
                refresh: true,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetSpaceEventsBloc()
            ..add(
              GetSpaceEventsEvent.fetch(
                input: Variables$Query$GetEvents(
                  space: spaceId,
                  limit: 50,
                  endFrom: DateTime.now().toUtc(),
                  sort: Input$EventSortInput(
                    start: Enum$SortOrder.asc,
                  ),
                ),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => FollowSpaceBloc(
            getIt<SpaceRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => GetMySpaceEventRequestsBloc(
            spaceRepository: getIt<SpaceRepository>(),
          )..add(
              GetMySpaceEventRequestsEvent.fetch(
                spaceId: spaceId,
                limit: 100,
                skip: 0,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetSpaceEventRequestsBloc(
            spaceRepository: getIt<SpaceRepository>(),
          ),
        ),
      ],
      child: const _View(),
    );
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingSubscribe = false;
  bool _showSimpleHeader = false;
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_selectedTabIndex != _tabController.index) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldShowFloatingSubscribe = _scrollController.offset >= 250;
    final shouldShowSimpleHeader = _scrollController.offset >= 200;

    if (shouldShowFloatingSubscribe != _showFloatingSubscribe ||
        shouldShowSimpleHeader != _showSimpleHeader) {
      setState(() {
        _showFloatingSubscribe = shouldShowFloatingSubscribe;
        _showSimpleHeader = shouldShowSimpleHeader;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final user = context.watch<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    return BlocConsumer<GetSpaceDetailBloc, GetSpaceDetailState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (space) {
            context
                .read<FollowSpaceBloc>()
                .add(FollowSpaceEvent.checkFollowed(space: space));
            if (space.isAdmin(userId: user?.userId ?? '') ||
                space.isCreator(userId: user?.userId ?? '')) {
              context.read<GetSpaceEventRequestsBloc>().add(
                    GetSpaceEventRequestsEvent.fetch(
                      input: Variables$Query$GetSpaceEventRequests(
                        space: space.id ?? '',
                        limit: 20,
                        skip: 0,
                        state: Enum$EventJoinRequestState.pending,
                      ),
                      refresh: true,
                    ),
                  );
            }
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => Scaffold(
            body: Center(
              child: Loading.defaultLoading(context),
            ),
          ),
          failure: (_) {
            return Scaffold(
              appBar: const LemonAppBar(title: ""),
              body: EmptyList(
                emptyText: t.common.somethingWrong,
              ),
            );
          },
          loading: () => Scaffold(
            appBar: const LemonAppBar(title: ""),
            body: Center(
              child: Loading.defaultLoading(context),
            ),
          ),
          success: (space) {
            final isAdminOrCreator =
                space.isAdmin(userId: user?.userId ?? '') ||
                    space.isCreator(userId: user?.userId ?? '');
            return Scaffold(
              floatingActionButton:
                  _selectedTabIndex == 1 ? const LensAddPostsButton() : null,
              body: Stack(
                children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        if (notification.metrics.pixels >=
                            notification.metrics.maxScrollExtent - 100) {
                          context.read<ScrollNotificationBloc>().add(
                                const ScrollNotificationEvent.reachEnd(),
                              );
                        } else {
                          context.read<ScrollNotificationBloc>().add(
                                const ScrollNotificationEvent.scroll(),
                              );
                        }
                      }
                      return false;
                    },
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SpaceHeader(space: space),
                        SliverToBoxAdapter(
                          child: SpaceInfo(space: space),
                        ),
                        if (isAdminOrCreator)
                          BlocBuilder<GetSpaceEventRequestsBloc,
                              GetSpaceEventRequestsState>(
                            builder: (context, state) {
                              final requests = state.maybeWhen(
                                orElse: () => <SpaceEventRequest>[],
                                success: (response) => response.records
                                    .where(
                                      (request) =>
                                          request.state ==
                                          Enum$SpaceEventRequestState.pending,
                                    )
                                    .toList(),
                              );
                              final hasPending = requests.isNotEmpty;
                              return MultiSliver(
                                children: [
                                  if (hasPending) ...[
                                    SliverToBoxAdapter(
                                      child: Divider(
                                        color: colorScheme.outline,
                                      ),
                                    ),
                                    SizedBox(height: Spacing.small),
                                  ],
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Spacing.small,
                                      ),
                                      child: SpaceEventRequestsAdminList(
                                        spaceId: space.id ?? '',
                                        requests: requests,
                                      ),
                                    ),
                                  ),
                                  if (!hasPending) ...[
                                    SliverToBoxAdapter(
                                      child: SizedBox(height: Spacing.small),
                                    ),
                                    SliverToBoxAdapter(
                                      child: Divider(
                                        color: colorScheme.outline,
                                      ),
                                    ),
                                  ],
                                  if (hasPending)
                                    SliverToBoxAdapter(
                                      child: SizedBox(height: Spacing.small),
                                    ),
                                ],
                              );
                            },
                          ),
                        SliverPersistentHeader(
                          delegate: _SliverTabBarDelegate(
                            TabBar(
                              controller: _tabController,
                              labelStyle: Typo.medium.copyWith(
                                color: colorScheme.onPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedLabelStyle: Typo.medium.copyWith(
                                color: colorScheme.onPrimary.withOpacity(0.36),
                                fontWeight: FontWeight.w500,
                              ),
                              indicatorColor: LemonColor.paleViolet,
                              onTap: (index) {
                                setState(() {
                                  _selectedTabIndex = index;
                                });
                              },
                              tabs: const [
                                Tab(text: "Events"),
                                Tab(text: "Feed"),
                              ],
                            ),
                          ),
                          pinned: true,
                        ),
                        if (_selectedTabIndex == 0) ...[
                          SpaceEventsList(space: space),
                        ] else if (_selectedTabIndex == 1) ...[
                          LensPostFeedWidget(space: space),
                        ],
                      ],
                    ),
                  ),
                  _FloatingSpaceHeader(
                    title: space.title ?? '',
                    showSimpleHeader: _showSimpleHeader,
                  ),
                  BlocBuilder<FollowSpaceBloc, FollowSpaceState>(
                    builder: (context, state) {
                      return _FloatingFollowButton(
                        visible: _showFloatingSubscribe &&
                            (space.canFollow(userId: user?.userId ?? '') &&
                                state is! FollowSpaceStateFollowed),
                        isLoading: state is FollowSpaceStateLoading,
                        onTap: () {
                          if (user?.userId == null ||
                              user?.userId.isEmpty == true) {
                            context.router.navigate(const LoginRoute());
                          }
                          context.read<FollowSpaceBloc>().add(
                                FollowSpaceEvent.follow(
                                  spaceId: space.id ?? '',
                                ),
                              );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return tabBar;
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

class _FloatingSpaceHeader extends StatelessWidget {
  final String title;
  const _FloatingSpaceHeader({
    required this.showSimpleHeader,
    required this.title,
  });

  final bool showSimpleHeader;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: showSimpleHeader ? 0 : -(LemonAppBar.height + statusBarHeight),
      left: 0,
      right: 0,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          bottom: false,
          child: LemonAppBar(
            title: title,
          ),
        ),
      ),
    );
  }
}

class _FloatingFollowButton extends StatelessWidget {
  const _FloatingFollowButton({
    required this.isLoading,
    required this.onTap,
    required this.visible,
  });
  final bool isLoading;
  final VoidCallback onTap;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      bottom: visible ? Spacing.large : -2 * Spacing.large,
      left: 0,
      right: 0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.small),
          child: SizedBox(
            height: 49.w,
            child: LinearGradientButton.primaryButton(
              label: t.common.actions.subscribe,
              loadingWhen: isLoading,
              onTap: () {
                if (isLoading) {
                  return;
                }
                onTap();
              },
            ),
          ),
        ),
      ),
    );
  }
}
