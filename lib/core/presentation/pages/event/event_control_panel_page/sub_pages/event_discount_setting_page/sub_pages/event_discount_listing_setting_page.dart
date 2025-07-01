import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_discount_setting_page/widgets/discount_item/discount_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventDiscountListingSetttingPage extends StatelessWidget {
  const EventDiscountListingSetttingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final t = Translations.of(context);
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    final discounts = event?.paymentTicketDiscounts ?? [];

    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.eventPromotions.eventPromotionsTitle,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: CustomScrollView(
              slivers: [
                if (discounts.isEmpty)
                  SliverToBoxAdapter(
                    child: EmptyList(
                      emptyText: t.event.eventPromotions.emptyDiscounts,
                    ),
                  ),
                if (discounts.isNotEmpty)
                  SliverList.separated(
                    itemCount: discounts.length,
                    itemBuilder: (context, index) {
                      return EventDiscountItem(discount: discounts[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: Spacing.xSmall,
                    ),
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Spacing.xLarge * 2.5,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              decoration: BoxDecoration(
                color: appColors.pageBg,
                border: Border(
                  top: BorderSide(color: appColors.pageDivider),
                ),
              ),
              child: SafeArea(
                child: LinearGradientButton.secondaryButton(
                  onTap: () => AutoRouter.of(context).push(
                    EventDiscountFormSettingRoute(),
                  ),
                  label: t.common.actions.add,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
