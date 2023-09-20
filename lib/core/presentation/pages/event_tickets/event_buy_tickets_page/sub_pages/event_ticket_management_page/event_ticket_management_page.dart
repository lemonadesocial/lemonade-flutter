import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_ticket_management_page/widgets/my_ticket_card.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_ticket_management_page/widgets/ticket_assignments_list.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventTicketManagementPage extends StatelessWidget {
  const EventTicketManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventTicketManagementView();
  }
}

class EventTicketManagementView extends StatelessWidget {
  const EventTicketManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.event.eventTicketManagement.myTicket,
                          style: Typo.extraLarge.copyWith(
                            color: colorScheme.onPrimary,
                            fontFamily: FontFamily.nohemiVariable,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          t.event.eventTicketManagement.myTicketDescription,
                          style: Typo.mediumPlus.copyWith(
                            color: colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: Spacing.smMedium)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    child: const MyTicketCard(),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: Spacing.large)),
                const TicketAssignmentList(),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: Spacing.medium * 4),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.smMedium,
                    horizontal: Spacing.smMedium,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.background,
                    border: Border(
                      top: BorderSide(
                        width: 2.w,
                        color: colorScheme.onPrimary.withOpacity(0.06),
                      ),
                    ),
                  ),
                  child: SizedBox(
                    height: Sizing.large,
                    child: Opacity(
                      opacity: 1, // 0.5 for disabled state,
                      child: LinearGradientButton(
                        radius: BorderRadius.circular(LemonRadius.small * 2),
                        mode: GradientButtonMode.lavenderMode,
                        label: t.event.takeMeToEvent,
                        textStyle: Typo.medium.copyWith(
                          fontFamily: FontFamily.nohemiVariable,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimary.withOpacity(0.87),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
