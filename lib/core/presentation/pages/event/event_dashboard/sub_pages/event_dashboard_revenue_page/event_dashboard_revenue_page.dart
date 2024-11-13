import 'package:app/core/domain/cubejs/cubejs_enums.dart';
import 'package:app/core/domain/cubejs/entities/cube_payment/cube_payment.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event/event_settings_page/sub_pages/event_discount_setting_page/widgets/discount_item/discount_item.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/insight_ticket_sales/insight_ticket_sales.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_revenue_page/widgets/dashboard_revenue_by_payment_kind.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_revenue_page/widgets/dashboard_revenue_by_ticket_type.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/empty_dotted_border_card_widget/empty_dotted_border_card_widget.dart';
import 'package:app/core/presentation/widgets/shimmer/shimmer.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/cubejs_service/cubejs_service.dart';
import 'package:app/core/utils/cubejs_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

Map<String, dynamic> getQuery(String eventId) => {
      "measures": ["Payments.totalAmount", "Payments.count"],
      "dimensions": ["Tickets.type", "Payments.kind", "Payments.currency"],
      "order": {
        "Payments.totalAmount": "desc",
      },
      "filters": [
        {
          "member": "Tickets.event",
          "operator": "equals",
          "values": [eventId],
        },
      ],
    };

class EventDashboardRevenuePage extends StatefulWidget {
  final Event event;
  const EventDashboardRevenuePage({
    super.key,
    required this.event,
  });

  @override
  State<EventDashboardRevenuePage> createState() =>
      _EventDashboardRevenuePageState();
}

class _EventDashboardRevenuePageState extends State<EventDashboardRevenuePage> {
  EventTicketType? getTicketType(String ticketTypeId) {
    return (widget.event.eventTicketTypes ?? [])
        .firstWhereOrNull((element) => element.id == ticketTypeId);
  }

  bool get hasPaidTicketType {
    return (widget.event.eventTicketTypes ?? []).any((element) {
      return (element.prices ?? [])
          .any((element) => (element.cryptoCost ?? BigInt.zero) > BigInt.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final discountCodes = widget.event.paymentTicketDiscounts ?? [];

    if (!hasPaidTicketType) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EmptyDottedBorderCardWidget(
              title: t.event.eventDashboard.insights.ticketSales,
              description:
                  t.event.eventDashboard.revenue.requirePaidTicketDescription,
              buttonLabel: t.event.eventDashboard.revenue.addTicket,
              onTap: () => AutoRouter.of(context).push(
                const EventTicketTierSettingRoute(),
              ),
            ),
          ],
        ),
      );
    }

    return FutureBuilder(
      future: CubeJsService(eventId: widget.event.id ?? '')
          .query(body: getQuery(widget.event.id ?? '')),
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final payments = snapshot.data?.fold(
              (l) => [].cast<CubePaymentMember>(),
              (result) => result
                  .map((json) => CubePaymentMember.fromJson(json))
                  .toList(),
            ) ??
            [];
        final paymentsByTicketTypeAndCurrency =
            CubeJsUtils.groupPaymentsByTicketTypeAndCurrency(payments)
                .entries
                .toList();
        final paymentsByPaymentKindTypeAndCurrency =
            CubeJsUtils.groupPaymentsByPaymentKindAndCurrency(payments)
                .entries
                .toList();
        if (isLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: CustomScrollView(
              slivers: [
                SliverList.separated(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: Sizing.medium,
                      child: Shimmer.fromColors(
                        baseColor: colorScheme.background,
                        highlightColor: LemonColor.atomicBlack,
                        child: Container(
                          color: colorScheme.background,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: Spacing.extraSmall),
                ),
              ],
            ),
          );
        }

        if (payments.isEmpty) {
          return const EmptyList();
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
          child: CustomScrollView(
            slivers: [
              SliverList.separated(
                itemBuilder: (context, index) {
                  final ticketTypeId =
                      paymentsByTicketTypeAndCurrency[index].key;
                  final isFirst = index == 0;
                  final isLast =
                      index == paymentsByTicketTypeAndCurrency.length - 1;
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
                      ),
                      topRight: Radius.circular(
                        isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
                      ),
                      bottomRight: Radius.circular(
                        isLast ? LemonRadius.medium : LemonRadius.extraSmall,
                      ),
                      bottomLeft: Radius.circular(
                        isLast ? LemonRadius.medium : LemonRadius.extraSmall,
                      ),
                    ),
                    child: EventDashboardRevenueByTicketType(
                      event: widget.event,
                      paymentsByCurrency:
                          paymentsByTicketTypeAndCurrency[index].value,
                      eventTicketType: getTicketType(ticketTypeId),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: Spacing.extraSmall,
                ),
                itemCount: paymentsByTicketTypeAndCurrency.length,
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: Spacing.large),
              ),
              // DashboardRevenueTotalTicketsSold(payments: payments),
              SliverList.separated(
                itemBuilder: (context, index) {
                  final paymentKind =
                      paymentsByPaymentKindTypeAndCurrency[index].key;
                  final isFirst = index == 0;
                  final isLast =
                      index == paymentsByPaymentKindTypeAndCurrency.length - 1;
                  String label =
                      t.event.eventDashboard.revenue.unknowPaymentKind;
                  Widget icon = ThemeSvgIcon(
                    color: colorScheme.onSecondary,
                    builder: (filter) => Assets.icons.icCash.svg(
                      colorFilter: filter,
                    ),
                  );
                  if (paymentKind == CubePaymentKind.Fiat.name) {
                    label = t.event.eventDashboard.revenue.cardSales;
                  }
                  if (paymentKind == CubePaymentKind.Crypto.name) {
                    label = t.event.eventDashboard.revenue.cryptoSales;
                    icon = ThemeSvgIcon(
                      color: colorScheme.onSecondary,
                      builder: (filter) => Assets.icons.icWallet.svg(
                        colorFilter: filter,
                      ),
                    );
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
                      ),
                      topRight: Radius.circular(
                        isFirst ? LemonRadius.medium : LemonRadius.extraSmall,
                      ),
                      bottomRight: Radius.circular(
                        isLast ? LemonRadius.medium : LemonRadius.extraSmall,
                      ),
                      bottomLeft: Radius.circular(
                        isLast ? LemonRadius.medium : LemonRadius.extraSmall,
                      ),
                    ),
                    child: EventDashboardRevenueByPaymentKind(
                      event: widget.event,
                      paymentsByCurrency:
                          paymentsByPaymentKindTypeAndCurrency[index].value,
                      icon: icon,
                      paymentKindLabel: label,
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: Spacing.extraSmall,
                ),
                itemCount: paymentsByPaymentKindTypeAndCurrency.length,
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: Spacing.large),
              ),
              SliverToBoxAdapter(
                child: InsightTicketSales(
                  eventId: widget.event.id ?? '',
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: Spacing.large),
              ),
              if (discountCodes.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Text(
                    t.event.eventPromotions.eventPromotionsTitle,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.small),
                ),
                SliverList.separated(
                  itemCount: discountCodes.length,
                  itemBuilder: (context, index) {
                    return EventDiscountItem(discount: discountCodes[index]);
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: Spacing.xSmall),
                ),
              ],
              SliverToBoxAdapter(
                child: SizedBox(height: Spacing.large * 2),
              ),
            ],
          ),
        );
      },
    );
  }
}
