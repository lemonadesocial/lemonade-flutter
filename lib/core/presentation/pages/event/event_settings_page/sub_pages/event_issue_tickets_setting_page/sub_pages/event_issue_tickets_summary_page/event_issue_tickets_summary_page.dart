import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_issue_tickets_setting_page/sub_pages/event_issue_tickets_summary_page/widgets/event_issue_tickets_summary.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EventIssueTicketsSummaryPage extends StatelessWidget {
  const EventIssueTicketsSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const LemonAppBar(),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.event.issueTickets.issueTicketsSummaryTitle,
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.nohemiVariable,
                        ),
                      ),
                      SizedBox(height: Spacing.superExtraSmall),
                      Text(
                        t.event.issueTickets.issueTicketsSummaryDescription,
                        style: Typo.mediumPlus.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.large),
                ),
                const SliverToBoxAdapter(
                  child: EventIssueTicketsSummary(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                ),
                padding: EdgeInsets.all(Spacing.smMedium),
                child: LinearGradientButton.primaryButton(
                  label: t.event.issueTickets.confirmAndIssue,
                  textColor: colorScheme.onPrimary,
                  onTap: () async {
                    AutoRouter.of(context).replaceAll([
                      const EventIssueTicketsProcessingRoute(),
                    ]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
