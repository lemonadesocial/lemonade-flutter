import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/ticket_counter.dart';
import 'package:app/core/presentation/widgets/image_placeholder_widget.dart';
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
  });

  final Event event;
  final PurchasableTicketType ticketType;
  final int count;
  final Currency? selectedCurrency;
  final SupportedPaymentNetwork? selectedNetwork;
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
    if (newCount == 0) {
      // TODO: call clear all selected ticket and clear selected currency, selected network in
      // select ticket bloc
    }
    onCountChange(newCount, currency, network);
  }

  @override
  Widget build(BuildContext context) {
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
                ...(ticketType.prices?.entries ?? []).map((e) {
                  // TODO: when backend update => e.value.currency;
                  final isCryptoCurrency = PaymentUtils.isCryptoCurrency(e.key);
                  bool enabled = true;
                  if (selectedCurrency == null) {
                    enabled = true;
                  } else {
                    enabled = e.key == selectedCurrency &&
                        (isCryptoCurrency
                            ? e.value.chainId == selectedNetwork
                            : true);
                  }

                  return Container(
                    margin: EdgeInsets.only(bottom: Spacing.extraSmall),
                    child: _PriceItem(
                      count: enabled ? count : 0,
                      currency: e.key,
                      price: e.value,
                      disabled: !enabled,
                      onIncrease: (newCount) {
                        add(
                          newCount: newCount,
                          currency: e.key,
                          network: e.value.chainId,
                        );
                      },
                      onDecrease: (newCount) {
                        minus(
                          newCount: newCount,
                          currency: e.key,
                          network: e.value.chainId,
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
  final bool disabled;
  final Function(int newCount) onDecrease;
  final Function(int newCount) onIncrease;
  final int count;

  const _PriceItem({
    super.key,
    required this.count,
    required this.currency,
    required this.price,
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCryptoCurrency && price.chainId != null) ...[
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
                  child: Web3Utils.getNetworkMetadataById(price.chainId!.value)
                      .icon,
                ),
              ),
              SizedBox(width: Spacing.xSmall),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isCryptoCurrency
                      ? Web3Utils.formatCryptoCurrency(
                          price.cryptoCost ?? BigInt.zero,
                          currency: currency,
                          // TODO: gen currency info
                          decimals: 8,
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
                // Mock data
                if (isCryptoCurrency && price.chainId != null) ...[
                  SizedBox(height: 2.w),
                  Text(
                    Web3Utils.getNetworkMetadataById(price.chainId!.value)
                        .displayName,
                    style: Typo.small.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
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
