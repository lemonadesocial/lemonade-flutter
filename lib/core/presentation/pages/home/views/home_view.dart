import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/common/refresh_bloc/refresh_bloc.dart';
import 'package:app/core/application/common/scroll_notification_bloc/scroll_notification_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/upcoming_events_listing_bloc.dart';
import 'package:app/core/application/newsfeed/newsfeed_listing_bloc/newsfeed_listing_bloc.dart';
import 'package:app/core/config.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_collaborators.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_my_events_list.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/lens_post_feed_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/i18n/i18n.g.dart';
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScrollNotificationBloc(),
        ),
        BlocProvider(
          create: (context) => UpcomingEventsListingBloc(
            EventService(getIt<EventRepository>()),
            defaultInput: GetUpcomingEventsInput(
              id: userId,
              limit: 100,
              sort: const GetEventSortInput(
                start: 1,
              ),
            ),
          )..add(
              BaseEventsListingEvent.fetch(),
            ),
        ),
      ],
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

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
      context.read<UpcomingEventsListingBloc>().add(
            BaseEventsListingEvent.fetch(),
          );
    } finally {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    final t = Translations.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<RefreshBloc, RefreshState>(
          listener: (context, state) {
            if (state is RefreshStateRefreshingEvents) {
              _refreshAllEvents();
            }
          },
        ),
        BlocListener<NewsfeedListingBloc, NewsfeedListingState>(
          listener: (context, state) {
            if (state.scrollToTopEvent) {
              context
                  .read<NewsfeedListingBloc>()
                  .scrollController
                  .animateTo(
                    context
                        .read<NewsfeedListingBloc>()
                        .scrollController
                        .position
                        .minScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  )
                  .then(
                    (_) => context.read<NewsfeedListingBloc>().add(
                          NewsfeedListingEvent.scrollToTop(
                            scrollToTopEvent: false,
                          ),
                        ),
                  );
            }
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          final isLoadingUpcomingEvents =
              context.watch<UpcomingEventsListingBloc>().state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );
          return RefreshIndicator(
            color: appColors.buttonTertiary,
            backgroundColor: appColors.buttonTertiaryBg,
            onRefresh: () async {
              _refreshAllEvents();
            },
            child: NotificationListener(
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
                    debouncer.run(() {
                      context.read<NewsfeedListingBloc>().add(
                            NewsfeedListingEvent.scrollToTop(
                              scrollToTopEvent: false,
                            ),
                          );
                    });
                  }
                }
                return false;
              },
              child: CustomScrollView(
                controller:
                    context.read<NewsfeedListingBloc>().scrollController,
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.s4,
                    ),
                    sliver: const SliverToBoxAdapter(
                      child: HomeCollaborators(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Spacing.s5,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(
                      color: appColors.pageDividerInverse,
                      thickness: Spacing.s1_5,
                    ),
                  ),
                  if (isLoadingUpcomingEvents)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                      sliver: SliverToBoxAdapter(
                        child: Loading.defaultLoading(context),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: Spacing.small,
                        right: Spacing.small,
                        top: Spacing.medium,
                      ),
                      sliver: BlocBuilder<UpcomingEventsListingBloc,
                          BaseEventsListingState>(
                        builder: (context, state) {
                          final events = state.maybeWhen(
                            orElse: () => <Event>[],
                            fetched: (events, filteredEvents) => events,
                          );
                          return HomeMyEventsList(events: events);
                        },
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: Spacing.s5,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(
                      color: appColors.pageDividerInverse,
                      thickness: Spacing.s1_5,
                    ),
                  ),
                  LensPostFeedWidget(
                    title: t.home.whatNew,
                    query: LensUtils.getDefaultFeedQueryInput(
                      lensFeedId: AppConfig.lemonadeGlobalFeed,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 120.h,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
