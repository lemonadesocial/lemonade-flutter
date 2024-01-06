import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/create_ticket_basic_info_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/create_ticket_guest_form.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_create_ticket_tier_page/widgets/create_ticket_pricing_form.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventCreateTicketTierPage extends StatelessWidget {
  const EventCreateTicketTierPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const LemonAppBar(
        title: "",
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    t.event.ticketTierSetting.createTicket,
                    style: Typo.extraLarge.copyWith(
                      fontWeight: FontWeight.w800,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.large,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CreateTicketBasicInfoForm(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.medium * 2,
                  ),
                ),
                const CreateTicketPricingForm(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.smMedium,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: CreateTicketGuestForm(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.xLarge * 3,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: colorScheme.background,
              padding: EdgeInsets.all(Spacing.smMedium),
              child: SafeArea(
                child: LinearGradientButton(
                  onTap: () {},
                  height: 42.w,
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  mode: GradientButtonMode.lavenderMode,
                  label: t.event.ticketTierSetting.addTicket,
                  textStyle: Typo.medium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
