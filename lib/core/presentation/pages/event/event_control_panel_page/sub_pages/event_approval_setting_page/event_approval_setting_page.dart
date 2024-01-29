import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/view/event_accepted_export_list.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_approval_setting_page/view/event_join_requests_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventApprovalSettingPage extends StatefulWidget {
  const EventApprovalSettingPage({super.key});

  @override
  State<EventApprovalSettingPage> createState() =>
      _EventApprovalSettingPageState();
}

class _EventApprovalSettingPageState extends State<EventApprovalSettingPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    final approvalRequired = event?.approvalRequired ?? false;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: t.event.eventApproval.guests,
      ),
      body: SafeArea(
        child: !approvalRequired
            ? SizedBox(
                child: EventAcceptedExportList(
                  event: event,
                ),
              )
            : DefaultTabController(
                initialIndex: 0,
                length: 4,
                child: Column(
                  children: [
                    TabBar(
                      labelStyle: Typo.small.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: Typo.small.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                      indicatorColor: LemonColor.paleViolet,
                      tabs: <Widget>[
                        Tab(text: t.event.eventApproval.tabs.reservations),
                        Tab(text: t.event.eventApproval.tabs.pending),
                        Tab(text: t.event.eventApproval.tabs.confirmed),
                        Tab(text: t.event.eventApproval.tabs.rejected),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          EventAcceptedExportList(event: event),
                          EventJoinRequestList(
                            state: Enum$JoinRequestState.pending,
                            event: event,
                          ),
                          EventJoinRequestList(
                            state: Enum$JoinRequestState.approved,
                            event: event,
                          ),
                          EventJoinRequestList(
                            state: Enum$JoinRequestState.declined,
                            event: event,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
