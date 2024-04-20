import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/event_dashboard_insight_page.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

@RoutePage()
class EventDashboardPage extends StatefulWidget {
  final String eventId;
  const EventDashboardPage({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDashboardPage> createState() => _EventDashboardPageState();
}

class _EventDashboardPageState extends State<EventDashboardPage> {
  late ValueNotifier<GraphQLClient> cubeClient;

  @override
  initState() {
    super.initState();
    cubeClient = ValueNotifier(CubeGQL(eventId: widget.eventId).client);
  }

  @override
  Widget build(BuildContext context) {
    final event = context
        .watch<GetEventDetailBloc>()
        .state
        .maybeWhen(orElse: () => null, fetched: (event) => event);
    return GraphQLProvider(
      client: cubeClient,
      child: Scaffold(
        appBar: const LemonAppBar(),
        body: Column(
          children: [
            if (event != null)
              Expanded(
                child: EventDashboardInsightPage(
                  event: event,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
