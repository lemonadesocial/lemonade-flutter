import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/common/refresh_bloc/refresh_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/base_events_listing_bloc.dart';
import 'package:app/core/application/event/events_listing_bloc/home_events_listing_bloc.dart';
import 'package:app/core/application/event/upcoming_attending_events_bloc/upcoming_attending_events_bloc.dart';
import 'package:app/core/application/event/upcoming_hosting_events_bloc/upcoming_hosting_events_bloc.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
import 'package:app/core/presentation/pages/event/widgets/event_time_filter_button_widget.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_collaborators.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_discover_events_list.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_hosting_events_list.dart';
import 'package:app/core/presentation/pages/home/views/widgets/home_my_events_list.dart';
import 'package:app/core/presentation/pages/home/views/widgets/no_upcoming_events_card.dart';
import 'package:app/core/presentation/pages/home/views/widgets/pending_invites_card.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/event/event_service.dart';
import 'package:app/graphql/backend/notification/query/get_notifications.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
          create: (context) => UpcomingHostingEventsBloc(userId: userId)
            ..add(UpcomingHostingEventsEvent.fetch()),
        ),
        BlocProvider(
          create: (context) => UpcomingAttendingEventsBloc(userId: userId)
            ..add(UpcomingAttendingEventsEvent.fetch()),
        ),
        BlocProvider(
          create: (context) => HomeEventListingBloc(
            EventService(getIt<EventRepository>()),
            defaultInput: const GetHomeEventsInput(
              limit: 10,
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

  void _selectEventTimeFilter(EventTimeFilter? mEventTimeFilter) {
    setState(() {
      eventTimeFilter = mEventTimeFilter;
    });
    context.read<HomeEventListingBloc>().add(
          BaseEventsListingEvent.filter(eventTimeFilter: eventTimeFilter),
        );
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
      context.read<HomeEventListingBloc>().add(
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
    return BlocListener<RefreshBloc, RefreshState>(
      listener: (context, state) {
        if (state is RefreshStateRefreshingEvents) {
          _refreshAllEvents();
        }
      },
      child: Builder(
        builder: (context) {
          final colorScheme = Theme.of(context).colorScheme;
          final t = Translations.of(context);
          final userId = context.watch<AuthBloc>().state.maybeWhen(
                authenticated: (authSession) => authSession.userId,
                orElse: () => '',
              );
          final isLoadingHomeEventListing = context
              .watch<HomeEventListingBloc>()
              .state
              .maybeWhen(loading: () => true, orElse: () => false);
          final isLoadingUpcomingAttendingEvents = context
              .watch<UpcomingAttendingEventsBloc>()
              .state
              .maybeWhen(loading: () => true, orElse: () => false);
          final isLoadingUpcomingHostingEvents = context
              .watch<UpcomingHostingEventsBloc>()
              .state
              .maybeWhen(loading: () => true, orElse: () => false);
          return RefreshIndicator(
            color: colorScheme.onPrimary,
            backgroundColor: LemonColor.chineseBlack,
            onRefresh: () => _refreshAllEvents(),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent * 0.8) {
                    debouncer.run(() {
                      context.read<HomeEventListingBloc>().add(
                            BaseEventsListingEvent.fetch(
                              eventTimeFilter: eventTimeFilter,
                            ),
                          );
                    });
                  }
                }
                return true;
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  if (_isRefreshing)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                      sliver: SliverToBoxAdapter(
                        child: Loading.defaultLoading(context),
                      ),
                    ),
                  const SliverToBoxAdapter(
                    child: HomeCollaborators(),
                  ),
                  if (userId.isNotEmpty)
                    Query$GetNotifications$Widget(
                      options: Options$Query$GetNotifications(
                        fetchPolicy: FetchPolicy.networkOnly,
                        variables: Variables$Query$GetNotifications(
                          limit: 20,
                          skip: 0,
                          type: Input$NotificationTypeFilterInput(
                            $in: [
                              Enum$NotificationType.event_cohost_request,
                              Enum$NotificationType.event_invite,
                              Enum$NotificationType.user_friendship_request,
                            ],
                          ),
                        ),
                      ),
                      builder: (result, {refetch, fetchMore}) {
                        if (result.hasException ||
                            result.isLoading ||
                            result.data == null) {
                          return const SliverToBoxAdapter();
                        }
                        final notifications =
                            result.parsedData?.getNotifications ?? [];
                        if (notifications.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        }

                        return SliverPadding(
                          padding: EdgeInsets.only(
                            top: Spacing.medium,
                            left: Spacing.small,
                            right: Spacing.small,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: PendingInvitesCard(
                              count: notifications.length,
                            ),
                          ),
                        );
                      },
                    ),
                  if (isLoadingUpcomingHostingEvents ||
                      isLoadingUpcomingAttendingEvents ||
                      isLoadingHomeEventListing)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                      sliver: SliverToBoxAdapter(
                        child: Loading.defaultLoading(context),
                      ),
                    ),
                  if (userId.isNotEmpty)
                    SliverPadding(
                      padding: EdgeInsets.only(
                        top: 30.w,
                        left: Spacing.small,
                        right: Spacing.small,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const HomeHostingEventsList(),
                          const HomeMyEventsList(),
                          BlocBuilder<UpcomingHostingEventsBloc,
                              UpcomingHostingEventsState>(
                            builder: (context, hostingState) {
                              return BlocBuilder<UpcomingAttendingEventsBloc,
                                  UpcomingAttendingEventsState>(
                                builder: (context, myEventsState) {
                                  final hostingEvents = hostingState.maybeWhen(
                                    fetched: (events) => events,
                                    orElse: () => [],
                                  );
                                  final myEvents = myEventsState.maybeWhen(
                                    fetched: (events) => events,
                                    orElse: () => [],
                                  );

                                  if (hostingEvents.isEmpty &&
                                      myEvents.isEmpty) {
                                    return const NoUpcomingEventsCard();
                                  }
                                  return const SizedBox.shrink();
                                },
                              );
                            },
                          ),
                        ]),
                      ),
                    ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t.discover.discover.toUpperCase(),
                            style: Typo.small.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          EventTimeFilterButton(
                            onSelect: _selectEventTimeFilter,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: Spacing.superExtraSmall),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                    sliver: HomeDiscoverEventsList(
                      eventTimeFilter: eventTimeFilter,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 120.h),
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
