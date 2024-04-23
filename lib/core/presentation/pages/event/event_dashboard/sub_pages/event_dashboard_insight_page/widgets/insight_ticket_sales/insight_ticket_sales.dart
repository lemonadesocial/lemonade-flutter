import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/cubejs/cubejs_enums.dart';
import 'package:app/core/domain/cubejs/entities/cube_payment/cube_payment.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/chart_date_range_builder/chart_date_range_builder.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/chart_date_range_builder/chart_date_range_picker.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/chart_empty_message/chart_empty_message.dart';
import 'package:app/core/presentation/pages/event/event_dashboard/sub_pages/event_dashboard_insight_page/widgets/chart_payment_kind_filter/chart_payment_kind_filter.dart';
import 'package:app/core/presentation/widgets/charts/line_chart/line_chart.dart';
import 'package:app/core/service/cubejs_service/cubejs_service.dart';
import 'package:app/core/utils/date_utils.dart' as date_utils;
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:matrix/matrix.dart' as matrix;

const defaultDateFormat = 'yyyy-MM-dd';
const displayDateFormat = 'dd-MMM';

Map<String, dynamic> getPaymentQuery(
  String eventId, {
  CubePaymentKind? paymentKind,
  DateTime? startDate,
  DateTime? endDate,
}) {
  final dateFormat = DateFormat(defaultDateFormat);
  final startDateFormatted = dateFormat.format(startDate ?? DateTime.now());
  final endDateFormatted = dateFormat.format(endDate ?? DateTime.now());
  final dateRange = [startDateFormatted, endDateFormatted];
  final filter = [
    {
      "member": 'Tickets.event',
      "operator": 'equals',
      "values": [eventId],
    },
    if (paymentKind != null) ...[
      {
        "member": 'Payments.kind',
        "operator": 'equals',
        "values": [paymentKind.name],
      }
    ],
  ];
  return {
    "measures": ["Payments.totalAmount", "Payments.count"],
    "dimensions": ["Payments.currency", "Payments.kind"],
    "timeDimensions": [
      {
        "dimension": "Payments.stampsSucceeded",
        "granularity": "day",
        "dateRange": dateRange,
      },
    ],
    "filters": filter,
  };
}

class InsightTicketSales extends StatefulWidget {
  final String eventId;
  const InsightTicketSales({
    super.key,
    required this.eventId,
  });

  @override
  State<InsightTicketSales> createState() => _InsightTicketSalesState();
}

class _InsightTicketSalesState extends State<InsightTicketSales> {
  CubePaymentKind? selectedPaymentKind;

  int _calculateTotalTicketsSold({required List<CubePaymentMember> payments}) {
    return payments.fold(0, (previousValue, element) {
      return (element.count ?? 0).toInt() + previousValue;
    });
  }

  Map<String, List<CubePaymentMember>> groupByCurrency({
    required List<CubePaymentMember> payments,
  }) =>
      groupBy(payments, (p0) => p0.currency ?? 'Unknown');

  String _calculateAmountByCurrency({
    Event? event,
    required List<CubePaymentMember> payments,
  }) {
    if (payments.isEmpty) {
      return '';
    }
    final currency = payments.first.currency ?? '';
    final isFiat = payments.first.kind == 'Fiat';
    final targetPaymentAccount =
        (event?.paymentAccountsExpanded ?? []).firstWhereOrNull(
      (element) => element.accountInfo?.currencies?.contains(currency) == true,
    );
    final decimals = targetPaymentAccount?.accountInfo?.currencyMap
            ?.tryGet<CurrencyInfo>(currency)
            ?.decimals ??
        0;
    final totalAmount = payments.fold(
      BigInt.zero,
      (previousValue, element) =>
          previousValue +
          (BigInt.tryParse(element.totalAmount ?? '0') ?? BigInt.zero),
    );

    if (isFiat) {
      return NumberUtils.formatCurrency(
        amount: totalAmount.toDouble(),
        attemptedDecimals: decimals,
      );
    }

    return Web3Utils.formatCryptoCurrency(
      totalAmount,
      currency: '',
      decimals: decimals,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );

    return ChartDateRangeBuilder(
      startDate: event?.start,
      endDate: event?.start?.add(
        const Duration(days: 30),
      ),
      builder: (
        timeRange, {
        required selectStartDate,
        required selectEndDate,
      }) =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.event.eventDashboard.insights.ticketSales,
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Spacing.smMedium),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (event != null) ...[
                ChartPaymentKindFilter(
                  selectedKind: selectedPaymentKind,
                  key: Key(selectedPaymentKind?.name ?? ''),
                  onSelect: (kind) {
                    setState(() {
                      selectedPaymentKind = kind;
                    });
                  },
                ),
                SizedBox(
                  width: Spacing.extraSmall,
                ),
              ],
              ChartDateRangePicker(
                timeRange: timeRange,
                onSelectEndDate: selectEndDate,
                onSelectStartDate: selectStartDate,
              ),
            ],
          ),
          SizedBox(height: Spacing.smMedium),
          FutureBuilder(
            future: CubeJsService(eventId: widget.eventId).query(
              body: getPaymentQuery(
                widget.eventId,
                paymentKind: selectedPaymentKind,
                startDate: timeRange.start,
                endDate: timeRange.end,
              ),
            ),
            builder: (context, snapshot) {
              final isLoading =
                  snapshot.connectionState == ConnectionState.waiting;
              final payments = snapshot.data?.fold(
                    (l) => [].cast<CubePaymentMember>(),
                    (result) => result
                        .map((json) => CubePaymentMember.fromJson(json))
                        .toList(),
                  ) ??
                  [];
              final paymentsByDate = groupBy(
                payments,
                (p) => DateFormat(defaultDateFormat).format(
                  p.stampsSucceeded?.toLocal() ?? DateTime.now(),
                ),
              );
              final allDatesInRange = date_utils.DateUtils.generateDatesInRange(
                timeRange.start,
                timeRange.end,
              ).map((item) {
                return DateFormat(defaultDateFormat).format(item.toLocal());
              }).toList();

              final allPaymentsByDateInRange =
                  allDatesInRange.fold<Map<String, List<CubePaymentMember>>>(
                {},
                (data, element) => data
                  ..putIfAbsent(element, () => paymentsByDate[element] ?? []),
              );

              final allDateKeys = allPaymentsByDateInRange.keys.toList();

              final spots = allPaymentsByDateInRange.entries
                  .map(
                    (entry) => FlSpot(
                      allDateKeys
                          .indexWhere((element) => element == entry.key)
                          .toDouble(),
                      entry.value.isNotEmpty ? 1 : 0,
                    ),
                  )
                  .toList();
              return Stack(
                children: [
                  LemonLineChart(
                    lineVisible: payments.isNotEmpty,
                    lineColor: LemonColor.malachiteGreen,
                    data: spots,
                    minY: -0.05,
                    maxY: 1.5,
                    minX: 0,
                    xTitlesWidget: (value, meta) => allDatesInRange.isNotEmpty
                        ? Text(
                            DateFormat(displayDateFormat).format(
                              DateTime.parse(allDatesInRange[value.toInt()]),
                            ),
                            style: Typo.small
                                .copyWith(color: colorScheme.onSecondary),
                          )
                        : const SizedBox.shrink(),
                    yTitlesWidget: (value, meta) => const SizedBox.shrink(),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => LemonColor.atomicBlack,
                        getTooltipItems: (touchedSpots) {
                          return touchedSpots.map((item) {
                            final dateKey = allDateKeys[item.x.toInt()];
                            final allPaymentsInDate =
                                allPaymentsByDateInRange[dateKey] ?? [];
                            final displayAmountForEachCurrency =
                                groupByCurrency(payments: allPaymentsInDate)
                                    .entries
                                    .fold<Map<String, String>>(
                              {},
                              (value, entry) => value
                                ..putIfAbsent(
                                  entry.key,
                                  () => _calculateAmountByCurrency(
                                    event: event,
                                    payments: entry.value,
                                  ),
                                ),
                            );
                            final amountTexts = displayAmountForEachCurrency
                                .entries
                                .map((entry) {
                              return '${entry.key}: ${entry.value}';
                            }).join('\n');

                            return LineTooltipItem(
                              '$dateKey \n',
                              Typo.xSmall.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${t.event.eventDashboard.insights.ticketsSold}: ',
                                  children: [
                                    TextSpan(
                                      text: _calculateTotalTicketsSold(
                                        payments:
                                            allPaymentsByDateInRange[dateKey] ??
                                                [],
                                      ).toString(),
                                    ),
                                  ],
                                ),
                                if (allPaymentsInDate.isNotEmpty)
                                  TextSpan(
                                    text: '\n$amountTexts',
                                  ),
                              ],
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                  if (payments.isNotEmpty)
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Spacing.smMedium,
                          horizontal: Spacing.smMedium,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              t.event.eventDashboard.insights.totalTicketsSold,
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            Text(
                              _calculateTotalTicketsSold(payments: payments)
                                  .toString(),
                              style: Typo.mediumPlus.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (payments.isEmpty || isLoading)
                    ChartEmptyMessage(
                      isLoading: isLoading,
                      title: t.event.eventDashboard.insights.totalCardSales,
                      description: t.event.eventDashboard.insights
                          .noTotalCardSalesDescription,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
