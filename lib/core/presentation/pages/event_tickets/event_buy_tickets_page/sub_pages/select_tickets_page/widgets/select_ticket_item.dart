import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/ticket_counter.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTicketItem extends StatelessWidget {
  const SelectTicketItem({
    super.key,
    required this.ticketType,
    required this.event,
    required this.onCountChange,
    required this.count,
    this.selectedCurrency,
    this.selectedNetwork,
    this.networkFilter,
  });

  final Event event;
  final PurchasableTicketType ticketType;
  final int count;
  final Currency? selectedCurrency;
  final SupportedPaymentNetwork? selectedNetwork;
  final SupportedPaymentNetwork? networkFilter;
  final Function(int count, Currency currency, SupportedPaymentNetwork? network)
      onCountChange;

  void add({
    required int newCount,
    required Currency currency,
    SupportedPaymentNetwork? network,
  }) {
    if (newCount < (ticketType.limit ?? 0)) {
      onCountChange(newCount, currency, network);
    }
  }

  void minus({
    required int newCount,
    required Currency currency,
    SupportedPaymentNetwork? network,
  }) {
    onCountChange(newCount, currency, network);
  }

  @override
  Widget build(BuildContext context) {
    List<EventCurrency> eventCurrencies =
        context.watch<GetEventTicketTypesBloc>().state.maybeWhen(
              orElse: () => [],
              success: (_, currencies) => currencies,
            );
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final costText = NumberUtils.formatCurrency(
      amount: (ticketType.defaultPrice?.fiatCost?.toDouble() ?? 0),
      currency: ticketType.defaultCurrency,
      freeText: t.event.free,
    );
    return Padding(
      padding: EdgeInsets.all(Spacing.smMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(LemonRadius.extraSmall),
              child: CachedNetworkImage(
                // TODO: api does not support yet
                imageUrl: "",
                placeholder: (_, __) => ImagePlaceholder.defaultPlaceholder(),
                errorWidget: (_, __, ___) =>
                    ImagePlaceholder.defaultPlaceholder(),
              ),
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          // ticket type name and description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "${ticketType.title}  •  $costText",
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (ticketType.description != null &&
                    ticketType.description!.isNotEmpty) ...[
                  SizedBox(height: 2.w),
                  Text(
                    ticketType.description ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: Spacing.xSmall),
                ...(ticketType.prices ?? []).map((ticketPrice) {
                  // Only apply for crypto flow, hide price item with network different
                  // with current selected network filter
                  if (ticketPrice.network != null &&
                      networkFilter != null &&
                      ticketPrice.network != networkFilter) {
                    return const SizedBox.shrink();
                  }

                  final isCryptoCurrency =
                      PaymentUtils.isCryptoCurrency(ticketPrice.currency!);
                  bool enabled = true;
                  if (selectedCurrency == null) {
                    enabled = true;
                  } else {
                    enabled = ticketPrice.currency == selectedCurrency &&
                        (isCryptoCurrency
                            ? ticketPrice.network == selectedNetwork
                            : true);
                  }
                  final decimals = EventTicketUtils.getEventCurrency(
                        currencies: eventCurrencies,
                        currency: ticketPrice.currency,
                        network: ticketPrice.network,
                      )?.decimals?.toInt() ??
                      2;

                  return Container(
                    margin: EdgeInsets.only(bottom: Spacing.extraSmall),
                    child: _PriceItem(
                      decimals: decimals,
                      count: enabled ? count : 0,
                      currency: ticketPrice.currency!,
                      price: ticketPrice,
                      disabled: !enabled,
                      onIncrease: (newCount) {
                        add(
                          newCount: newCount,
                          currency: ticketPrice.currency!,
                          network: ticketPrice.network,
                        );
                      },
                      onDecrease: (newCount) {
                        minus(
                          newCount: newCount,
                          currency: ticketPrice.currency!,
                          network: ticketPrice.network,
                        );
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceItem extends StatelessWidget {
  final Currency currency;
  final EventTicketPrice price;
  final int decimals;
  final bool disabled;
  final Function(int newCount) onDecrease;
  final Function(int newCount) onIncrease;
  final int count;

  const _PriceItem({
    required this.currency,
    required this.count,
    required this.price,
    required this.decimals,
    required this.disabled,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCryptoCurrency = PaymentUtils.isCryptoCurrency(currency);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isCryptoCurrency && price.network != null) ...[
                Container(
                  decoration: ShapeDecoration(
                    color: LemonColor.chineseBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Sizing.medium,
                      ),
                    ),
                  ),
                  width: Sizing.medium,
                  height: Sizing.medium,
                  child: Center(
                    child:
                        Web3Utils.getNetworkMetadataById(price.network!.value)
                            .icon,
                  ),
                ),
                SizedBox(width: Spacing.xSmall),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isCryptoCurrency
                          ? Web3Utils.formatCryptoCurrency(
                              price.cryptoCost ?? BigInt.zero,
                              currency: currency,
                              decimals: decimals,
                            )
                          : NumberUtils.formatCurrency(
                              amount: price.fiatCost ?? 0,
                              currency: currency,
                            ),
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary.withOpacity(0.87),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isCryptoCurrency && price.network != null) ...[
                      SizedBox(height: 2.w),
                      Text(
                        Web3Utils.getNetworkMetadataById(price.network!.value)
                            .displayName,
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: Spacing.xSmall),
        TicketCounter(
          count: count,
          onDecrease: onDecrease,
          onIncrease: onIncrease,
          disabled: disabled,
        ),
      ],
    );
  }
}
