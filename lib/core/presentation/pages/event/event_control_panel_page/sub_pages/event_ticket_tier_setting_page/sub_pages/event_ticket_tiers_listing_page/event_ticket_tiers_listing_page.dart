import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_ticket_tiers_listing_page/widgets/payout_accounts_widget.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_ticket_tiers_listing_page/widgets/ticket_tier_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventTicketTiersListingPage extends StatelessWidget {
  const EventTicketTiersListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventTicketTypes =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
                  fetched: (event) => event.eventTicketTypes,
                  orElse: () => [] as List<EventTicketType>,
                ) ??
            [];
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: StringUtils.capitalize(
          t.event.tickets(n: 2),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.xSmall,
            ),
            child: CustomScrollView(
              slivers: [
                SliverList.separated(
                  separatorBuilder: (context, index) =>
                      SizedBox(height: Spacing.xSmall),
                  itemBuilder: (context, index) => TicketTierItem(
                    eventTicketType: eventTicketTypes[index],
                  ),
                  itemCount: eventTicketTypes.length,
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.smMedium,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: PayoutAccountsWidget(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xLarge * 3),
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
                  onTap: () {
                    AutoRouter.of(context)
                        .navigate(EventCreateTicketTierRoute());
                  },
                  height: 42.w,
                  leading: Assets.icons.icAdd.svg(),
                  radius: BorderRadius.circular(LemonRadius.small * 2),
                  mode: GradientButtonMode.lavenderMode,
                  label: t.event.ticketTierSetting.newTicket,
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
