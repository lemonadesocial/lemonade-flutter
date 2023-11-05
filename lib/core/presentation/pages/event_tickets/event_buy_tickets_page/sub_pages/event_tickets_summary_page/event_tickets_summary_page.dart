import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/event_tickets/redeem_tickets_bloc/redeem_tickets_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/application/payment/payment_bloc/payment_bloc.dart';
import 'package:app/core/domain/event/input/calculate_tickets_pricing_input/calculate_tickets_pricing_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/add_promo_code_input.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_summary.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_order_summary_footer.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/event_tickets_summary_page/widgets/event_tickets_summary.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/date_format_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class EventTicketsSummaryPage extends StatelessWidget {
  const EventTicketsSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventTicketsSummaryPageView();
  }
}

class EventTicketsSummaryPageView extends StatefulWidget {
  const EventTicketsSummaryPageView({
    super.key,
  });

  @override
  State<EventTicketsSummaryPageView> createState() =>
      _EventTicketsSummaryPageViewState();
}

class _EventTicketsSummaryPageViewState
    extends State<EventTicketsSummaryPageView> {
  @override
  void initState() {
    super.initState();
    final event = context.read<EventProviderBloc>().event;
    final selectedTickets =
        context.read<SelectEventTicketTypesBloc>().state.selectedTicketTypes;
    final selectedCurrency =
        context.read<SelectEventTicketTypesBloc>().state.selectedCurrency;

    context.read<PaymentBloc>()
      ..getListCard()
      ..calculatePricing(
        input: CalculateTicketsPricingInput(
          eventId: event.id ?? '',
          items: selectedTickets,
          // TODO: In the future, user will select currency to pay, and all the selected ticket types
          // will be the
          currency: selectedCurrency!,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.read<EventProviderBloc>().event;

    return BlocConsumer<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state.status == PaymentStatus.success) {
          final redeemTicketBloc = context.read<RedeemTicketsBloc>();
          final selectEventBloc = context.read<SelectEventTicketTypesBloc>();
          redeemTicketBloc.add(
            RedeemTicketsEvent.redeem(
              ticketItems: selectEventBloc.state.selectedTicketTypes,
            ),
          );
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colorScheme.background,
        appBar: const LemonAppBar(),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.event.eventBuyTickets.orderSummary,
                            style: Typo.extraLarge.copyWith(
                              color: colorScheme.onPrimary,
                              fontFamily: FontFamily.nohemiVariable,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            "${event.title}  •  ${DateFormatUtils.dateOnly(event.start)}",
                            style: Typo.mediumPlus.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Spacing.large),
                    const EventTicketsSummary(),
                    SizedBox(height: Spacing.smMedium),
                    const AddPromoCodeInput(),
                    SizedBox(height: Spacing.smMedium),
                    EventOrderSummary(priceDetail: state.pricingInfo),
                    SizedBox(height: 150.w + Spacing.medium),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: EventOrderSummaryFooter(
                  totalPrice: state.pricingInfo?.total ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
