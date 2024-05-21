import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/my_events_listing_bloc/my_events_listing_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/input/get_events_listing_input.dart';
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
import 'package:slang/builder/utils/string_extensions.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;

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
          create: (context) => MyEventsListingBloc(
            defaultInput: GetHostingEventsInput(id: userId),
          )..add(MyEventsListingEvent.fetch()),
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
        initialIndex: 0,
        length: 2,
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
                Tab(text: t.event.upcoming.capitalize()),
                Tab(text: t.event.past.capitalize()),
              ],
            ),
            Expanded(
              child: BlocBuilder<MyEventsListingBloc, MyEventsListingState>(
                builder: (context, state) => state.when(
                  loading: () => Loading.defaultLoading(context),
                  failure: () => EmptyList(
                    emptyText: t.common.somethingWrong,
                  ),
                  fetched: (events) {
                    List<Event> upcomingEvents = events
                        .where(
                          (event) =>
                              // Upcoming events
                              !date_utils.DateUtils.isPast(event.start) ||
                              // Current live events
                              (date_utils.DateUtils.isPast(event.start) &&
                                  !date_utils.DateUtils.isPast(event.end)),
                        )
                        .toList()
                      ..sort((a, b) => b.start!.compareTo(a.start!));
                    List<Event> pastEvents = events
                        .where(
                          (event) => date_utils.DateUtils.isPast(event.end),
                        )
                        .toList()
                      ..sort((a, b) => b.end!.compareTo(a.end!));
                    return TabBarView(
                      children: [
                        MyEventsListView(
                          events: upcomingEvents,
                        ),
                        MyEventsListView(
                          events: pastEvents,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
