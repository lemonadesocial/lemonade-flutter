import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/past_hosting_events_bloc/past_hosting_events_bloc.dart';
import 'package:app/core/application/event/upcoming_hosting_events_bloc/upcoming_hosting_events_bloc.dart';
import 'package:app/core/application/event/draft_hosting_events_bloc/draft_hosting_events_bloc.dart';
import 'package:app/core/presentation/pages/event/my_events_page/views/my_events_list_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/string_utils.dart';

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

class MyEventsPageView extends StatelessWidget {
  const MyEventsPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: t.event.events.capitalize(),
      ),
      body: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Column(
          children: [
            TabBar(
              labelStyle: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: Typo.medium.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              indicatorColor: LemonColor.paleViolet,
              tabs: <Widget>[
                Tab(text: t.event.draft.capitalize()),
                Tab(text: t.event.upcoming.capitalize()),
                Tab(text: t.event.past.capitalize()),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  BlocBuilder<DraftHostingEventsBloc, DraftHostingEventsState>(
                    builder: (context, state) => state.when(
                      loading: () => Loading.defaultLoading(context),
                      failure: () => EmptyList(
                        emptyText: t.common.somethingWrong,
                      ),
                      fetched: (draftEvents) => MyEventsListView(
                        events: draftEvents,
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
