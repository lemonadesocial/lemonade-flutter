import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/past_hosting_events_bloc/past_hosting_events_bloc.dart';
import 'package:app/core/application/event/upcoming_hosting_events_bloc/upcoming_hosting_events_bloc.dart';
import 'package:app/core/application/event/draft_hosting_events_bloc/draft_hosting_events_bloc.dart';
import 'package:app/core/presentation/pages/event/my_events_page/views/my_events_list_view.dart';
import 'package:app/core/presentation/pages/event/my_events_page/widgets/my_events_empty_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/app_theme/app_theme.dart';

@RoutePage()
class MyEventsPage extends StatelessWidget {
  const MyEventsPage({super.key});

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
          create: (context) => PastHostingEventsBloc(userId: userId)
            ..add(PastHostingEventsEvent.fetch()),
        ),
        BlocProvider(
          create: (context) => DraftHostingEventsBloc(userId: userId)
            ..add(const DraftHostingEventsEvent.fetch()),
        ),
      ],
      child: const MyEventsPageView(),
    );
  }
}

class MyEventsPageView extends StatefulWidget {
  const MyEventsPageView({
    super.key,
  });

  @override
  State<MyEventsPageView> createState() => _MyEventsPageViewState();
}

class _MyEventsPageViewState extends State<MyEventsPageView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _hasDraftEvents = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: appColors.pageBg,
      appBar: LemonAppBar(
        backButtonColor: appColors.textTertiary,
        backgroundColor: appColors.pageBg,
        title: t.event.myEvents.capitalize(),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelStyle: appText.md,
            unselectedLabelStyle: appText.md.copyWith(
              color: appColors.textTertiary,
            ),
            indicatorColor: appColors.textAccent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: Spacing.s4),
            tabs: <Widget>[
              if (_hasDraftEvents) Tab(text: t.event.draft.capitalize()),
              Tab(text: t.event.upcoming.capitalize()),
              Tab(text: t.event.past.capitalize()),
            ],
          ),
          BlocListener<DraftHostingEventsBloc, DraftHostingEventsState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                fetched: (draftEvents) {
                  if (draftEvents.isNotEmpty) {
                    _tabController.dispose();
                    _tabController = TabController(length: 3, vsync: this);
                    setState(() {
                      _hasDraftEvents = true;
                    });
                  }
                },
              );
            },
            child: Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  if (_hasDraftEvents)
                    BlocBuilder<DraftHostingEventsBloc,
                        DraftHostingEventsState>(
                      builder: (context, state) => state.when(
                        loading: () => Loading.defaultLoading(context),
                        failure: () => EmptyList(
                          emptyText: t.common.somethingWrong,
                        ),
                        fetched: (draftEvents) => MyEventsListView(
                          events: draftEvents,
                          emptyType: MyEventsEmptyWidgetType.upcoming,
                        ),
                      ),
                    ),
                  BlocBuilder<UpcomingHostingEventsBloc,
                      UpcomingHostingEventsState>(
                    builder: (context, state) => state.when(
                      loading: () => Loading.defaultLoading(context),
                      failure: () => EmptyList(
                        emptyText: t.common.somethingWrong,
                      ),
                      fetched: (upcomingEvents) => MyEventsListView(
                        events: upcomingEvents,
                        emptyType: MyEventsEmptyWidgetType.upcoming,
                      ),
                    ),
                  ),
                  BlocBuilder<PastHostingEventsBloc, PastHostingEventsState>(
                    builder: (context, state) => state.when(
                      loading: () => Loading.defaultLoading(context),
                      failure: () => EmptyList(
                        emptyText: t.common.somethingWrong,
                      ),
                      fetched: (pastEvents) => MyEventsListView(
                        events: pastEvents,
                        emptyType: MyEventsEmptyWidgetType.past,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
