import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_issue_tickets_setting_page/sub_pages/event_issue_tickets_form_page/widgets/issue_tickets_assignment_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_issue_tickets_setting_page/sub_pages/event_issue_tickets_form_page/widgets/issue_tickets_dropdown.dart';
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
class EventIssueTicketsFormPage extends StatelessWidget {
  const EventIssueTicketsFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const LemonAppBar(),
      resizeToAvoidBottomInset: false,
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
                        t.event.issueTickets.issueTicketsTitle,
                        style: Typo.extraLarge.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.nohemiVariable,
                        ),
                      ),
                      SizedBox(height: Spacing.superExtraSmall),
                      Text(
                        t.event.issueTickets.issueTicketsDescription,
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
                // ticket dropdown
                const SliverToBoxAdapter(
                  child: IssueTicketsDropdown(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.medium),
                ),
                const SliverToBoxAdapter(
                  child: IssueTicketsAssignmentForm(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.superExtraSmall * 3),
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
                  onTap: () => AutoRouter.of(context).push(
                    const EventIssueTicketsSummaryRoute(),
                  ),
                  label: t.common.next,
                  textColor: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
