import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_issue_tickets_setting_page/sub_pages/event_issue_tickets_processing_page/view/event_issue_tickets_loading_view.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventIssueTicketsProcessingPage extends StatelessWidget {
  const EventIssueTicketsProcessingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: Spacing.smMedium),
          child: const EventIssueTicketsLoadingView(),
        ),
      ),
    );
  }
}
