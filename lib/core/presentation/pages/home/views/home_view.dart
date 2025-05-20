import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/common/refresh_bloc/refresh_bloc.dart';
import 'package:app/core/application/event/upcoming_attending_events_bloc/upcoming_attending_events_bloc.dart';
import 'package:app/core/application/event/upcoming_hosting_events_bloc/upcoming_hosting_events_bloc.dart';
import 'package:app/core/application/space/list_spaces_bloc/list_spaces_bloc.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_hosting_events_list.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_list_my_spaces.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_my_events_list.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/core/utils/debouncer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => '',
        );
    final mySpacesBloc = ListSpacesBloc(
      spaceRepository: getIt<SpaceRepository>(),
      withMySpaces: true,
      roles: [Enum$SpaceRole.admin, Enum$SpaceRole.creator],
    )..add(const ListSpacesEvent.fetch());

    final ambassadorSpacesBloc = ListSpacesBloc(
      spaceRepository: getIt<SpaceRepository>(),
      withMySpaces: false,
      roles: [Enum$SpaceRole.ambassador],
    )..add(const ListSpacesEvent.fetch());

    final subscribedSpacesBloc = ListSpacesBloc(
      spaceRepository: getIt<SpaceRepository>(),
      withMySpaces: false,
      roles: [Enum$SpaceRole.subscriber],
    )..add(const ListSpacesEvent.fetch());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpcomingHostingEventsBloc(userId: userId)
            ..add(UpcomingHostingEventsEvent.fetch()),
        ),
        BlocProvider(
          create: (context) => UpcomingAttendingEventsBloc(userId: userId)
            ..add(UpcomingAttendingEventsEvent.fetch()),
        ),
        BlocProvider<ListSpacesBloc>.value(value: mySpacesBloc),
        BlocProvider<ListSpacesBloc>.value(value: ambassadorSpacesBloc),
        BlocProvider<ListSpacesBloc>.value(value: subscribedSpacesBloc),
      ],
      child: _HomeView(
        mySpacesBloc: mySpacesBloc,
        ambassadorSpacesBloc: ambassadorSpacesBloc,
        subscribedSpacesBloc: subscribedSpacesBloc,
      ),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView({
    required this.mySpacesBloc,
    required this.ambassadorSpacesBloc,
    required this.subscribedSpacesBloc,
  });

  final ListSpacesBloc mySpacesBloc;
  final ListSpacesBloc ambassadorSpacesBloc;
  final ListSpacesBloc subscribedSpacesBloc;

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView>
    with WidgetsBindingObserver, AutoRouteAwareStateMixin {
  EventTimeFilter? eventTimeFilter;
  bool _isRefreshing = false;
  final debouncer = Debouncer(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debouncer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isAuthenticated = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (_) => true,
          orElse: () => false,
        );
    if (state == AppLifecycleState.resumed && isAuthenticated) {
      _refreshAllEvents();
    }
  }

  Future<void> _refreshAllEvents() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });
    try {
      // Simulate a delay to show the loading state
      await Future.delayed(const Duration(milliseconds: 1000));
      context.read<UpcomingHostingEventsBloc>().add(
            UpcomingHostingEventsEvent.fetch(),
          );
      context.read<UpcomingAttendingEventsBloc>().add(
            UpcomingAttendingEventsEvent.fetch(),
          );
      widget.mySpacesBloc.add(const ListSpacesEvent.fetch());
      widget.ambassadorSpacesBloc.add(const ListSpacesEvent.fetch());
      widget.subscribedSpacesBloc.add(const ListSpacesEvent.fetch());
    } finally {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return BlocListener<RefreshBloc, RefreshState>(
      listener: (context, state) {
        if (state is RefreshStateRefreshingEvents) {
          _refreshAllEvents();
        }
      },
      child: Builder(
        builder: (context) {
          final userId = context.watch<AuthBloc>().state.maybeWhen(
                authenticated: (authSession) => authSession.userId,
                orElse: () => '',
              );
          final isLoadingUpcomingAttendingEvents = context
              .watch<UpcomingAttendingEventsBloc>()
              .state
              .maybeWhen(loading: () => true, orElse: () => false);
          final isLoadingUpcomingHostingEvents = context
              .watch<UpcomingHostingEventsBloc>()
              .state
              .maybeWhen(loading: () => true, orElse: () => false);
          return RefreshIndicator(
            color: appColors.buttonTertiary,
            backgroundColor: appColors.buttonTertiaryBg,
            onRefresh: () async {
              _refreshAllEvents();
            },
            child: CustomScrollView(
              slivers: [
                if (isLoadingUpcomingHostingEvents ||
                    isLoadingUpcomingAttendingEvents)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                    sliver: SliverToBoxAdapter(
                      child: Loading.defaultLoading(context),
                    ),
                  ),
                if (userId.isNotEmpty)
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: Spacing.small,
                      right: Spacing.small,
                      top: Spacing.medium,
                    ),
                    sliver: SliverList.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: Spacing.s4,
                      ),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const HomeHostingEventsList();
                        }

                        return const HomeMyEventsList();
                      },
                    ),
                  ),
                SliverToBoxAdapter(
                  child: Divider(
                    color: appColors.pageDividerInverse,
                    thickness: Spacing.s1_5,
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: Spacing.s5,
                  ),
                  sliver: HomeListMySpaces(
                    mySpacesBloc: widget.mySpacesBloc,
                    ambassadorSpacesBloc: widget.ambassadorSpacesBloc,
                    subscribedSpacesBloc: widget.subscribedSpacesBloc,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 120.h,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
