import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/ticket_counter.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
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
    required this.selectedPaymentMethod,
    this.selectedCurrency,
    this.selectedNetwork,
    this.networkFilter,
  });

  final Event event;
  final PurchasableTicketType ticketType;
  final int count;
  final String? selectedCurrency;
  final SelectTicketsPaymentMethod selectedPaymentMethod;
  final String? selectedNetwork;
  final String? networkFilter;
  final Function(int count, String currency, String? network) onCountChange;

  void add({
    required int newCount,
    required String currency,
    String? network,
  }) {
    if (newCount < (ticketType.limit ?? 0)) {
      onCountChange(newCount, currency, network);
    }
  }

  void minus({
    required int newCount,
    required String currency,
    String? network,
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
    final ticketThumbnail = ImagePlaceholder.ticketThumbnail(
      iconColor: colorScheme.onSecondary,
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
                placeholder: (_, __) => ticketThumbnail,
                errorWidget: (_, __, ___) => ticketThumbnail,
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
                  ticketType.title ?? '',
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

                  final isCryptoCurrency = ticketPrice.network != null;

                  if (isCryptoCurrency &&
                      selectedPaymentMethod ==
                          SelectTicketsPaymentMethod.card) {
                    return const SizedBox.shrink();
                  }

                  if (!isCryptoCurrency &&
                      selectedPaymentMethod ==
                          SelectTicketsPaymentMethod.wallet) {
                    return const SizedBox.shrink();
                  }

                  // Only apply for crypto flow, hide price item with network different
                  // with current selected network filter
                  if (ticketPrice.network != null &&
                      networkFilter != null &&
                      ticketPrice.network != networkFilter) {
                    return const SizedBox.shrink();
                  }

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
                      network: ticketPrice.network,
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
  final String currency;
  final String? network;
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
    this.network,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCryptoCurrency = network != null;

    return ChainQuery(
      chainId: price.network ?? '',
      builder: (chain, {required isLoading}) => Row(
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Sizing.xSmall),
                        child: CachedNetworkImage(
                          imageUrl: chain?.logoUrl ?? '',
                          placeholder: (_, __) => const SizedBox.shrink(),
                          errorWidget: (_, __, ___) => const SizedBox.shrink(),
                          width: Sizing.xSmall,
                          height: Sizing.xSmall,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                          chain?.name ?? '',
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
            onPressDisabled: () {
              SnackBarUtils.showCustomSnackbar(
                MultipleTicketsErrorSnackbar.create(context),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MultipleTicketsErrorSnackbar {
  static SnackBar create(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    return SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          LemonRadius.normal,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: size.height - size.height * 0.2),
      backgroundColor: LemonColor.chineseBlack,
      showCloseIcon: true,
      closeIconColor: colorScheme.onSecondary,
      content: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(LemonRadius.normal),
              color: LemonColor.errorRedBg.withOpacity(0.2),
            ),
            width: Sizing.medium,
            height: Sizing.medium,
            child: Center(
              child: Assets.icons.icError.svg(),
            ),
          ),
          SizedBox(width: Spacing.small),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.event.error,
                  style: Typo.small.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 2.w,
                ),
                Text(
                  t.event.eventBuyTickets.multipleTicketsError,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
