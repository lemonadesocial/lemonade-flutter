import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/ticket_counter.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/core/utils/event_tickets_utils.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTicketItem extends StatelessWidget {
  const SelectTicketItem({
    super.key,
    required this.ticketType,
    required this.event,
    required this.onCountChange,
    this.networkFilter,
  });

  final Event event;
  final PurchasableTicketType ticketType;
  final String? networkFilter;
  final Function(int count) onCountChange;

  void add({
    required int newCount,
    required String currency,
  }) {
    onCountChange(newCount);
  }

  void minus({
    required int newCount,
    required String currency,
  }) {
    onCountChange(newCount);
  }

  @override
  Widget build(BuildContext context) {
    List<EventCurrency> eventCurrencies =
        context.watch<GetEventTicketTypesBloc>().state.maybeWhen(
              orElse: () => [],
              success: (_, currencies) => currencies,
            );
    final selectTicketsBloc = context.watch<SelectEventTicketsBloc>();
    final colorScheme = Theme.of(context).colorScheme;
    final isLocked =
        ticketType.limited == true && ticketType.whitelisted == false;
    final selectedCurrency = selectTicketsBloc.state.selectedCurrency;
    final count = selectTicketsBloc.state.selectedTickets
            .firstWhereOrNull(
              (element) => element.id == ticketType.id,
            )
            ?.count ??
        0;
    final commonPaymentAccounts = selectTicketsBloc.state.commonPaymentAccounts;

    return InkWell(
      onTap: () {
        if (!isLocked) {
          return;
        }
        SnackBarUtils.showCustom(
          icon: Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              color: LemonColor.chineseBlack,
              borderRadius: BorderRadius.circular(Sizing.medium),
            ),
            child: Center(
              child: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (colorFilter) => Assets.icons.icLock.svg(
                  width: Sizing.xSmall,
                  height: Sizing.xSmall,
                  colorFilter: colorFilter,
                ),
              ),
            ),
          ),
          title: t.event.eventBuyTickets.ticketLocked,
          message: t.event.eventBuyTickets.ticketLockedDescription,
        );
      },
      child: Stack(
        children: [
          Opacity(
            opacity: isLocked ? 0.5 : 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                borderRadius: BorderRadius.circular(LemonRadius.medium),
                border: Border.all(
                  color: colorScheme.outlineVariant,
                ),
              ),
              padding: EdgeInsets.all(Spacing.smMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ticketType.title ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  ...(ticketType.prices ?? []).map((ticketPrice) {
                    bool enabled = true;
                    if (selectedCurrency == null) {
                      enabled = true;
                    } else {
                      // Need to check if has common payment accounts
                      final newCommonPaymentAccounts =
                          PaymentUtils.getCommonPaymentAccounts(
                        accounts1: commonPaymentAccounts,
                        accounts2: ticketPrice.paymentAccountsExpanded ?? [],
                      );
                      if (ticketPrice.isCrypto) {
                        enabled = ticketPrice.currency == selectedCurrency &&
                            newCommonPaymentAccounts.isNotEmpty;
                      } else {
                        enabled = ticketPrice.currency == selectedCurrency;
                      }
                    }
                    final decimals = EventTicketUtils.getEventCurrency(
                          currencies: eventCurrencies,
                          currency: ticketPrice.currency,
                        )?.decimals?.toInt() ??
                        2;

                    return _PriceItem(
                      ticketType: ticketType,
                      decimals: decimals,
                      count: enabled ? count : 0,
                      currency: ticketPrice.currency!,
                      price: ticketPrice,
                      disabled: !enabled,
                      onIncrease: (newCount) {
                        add(
                          newCount: newCount,
                          currency: ticketPrice.currency!,
                        );
                      },
                      onDecrease: (newCount) {
                        minus(
                          newCount: newCount,
                          currency: ticketPrice.currency!,
                        );
                      },
                    );
                  }),
                  if (ticketType.description != null &&
                      ticketType.description!.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.only(
                        top: Spacing.xSmall,
                        right: isLocked ? Spacing.xLarge : 0,
                      ),
                      child: Text(
                        ticketType.description ?? '',
                        style: Typo.small.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceItem extends StatelessWidget {
  final String currency;
  final PurchasableTicketType ticketType;
  final EventTicketPrice price;
  final int decimals;
  final bool disabled;
  final Function(int newCount) onDecrease;
  final Function(int newCount) onIncrease;
  final int count;

  const _PriceItem({
    required this.currency,
    required this.ticketType,
    required this.price,
    required this.count,
    required this.decimals,
    required this.disabled,
    required this.onIncrease,
    required this.onDecrease,
  });

  bool get isStakingTicket {
    return price.paymentAccounts?.isNotEmpty == true &&
        (price.paymentAccountsExpanded?.every(
              (element) => element.type == PaymentAccountType.ethereumStake,
            ) ??
            false);
  }

  bool get isWhitelistExclusive {
    return ticketType.limited == true;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCryptoCurrency = price.isCrypto;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              style: Typo.mediumPlus.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (price.supportedNetworks.isNotEmpty) ...[
              SizedBox(height: Spacing.xSmall),
              SizedBox(
                height: 20.w,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ChainQuery(
                    chainId: price.supportedNetworks[index],
                    builder: (
                      chain, {
                      required isLoading,
                    }) {
                      if (isLoading) {
                        return const SizedBox.shrink();
                      }
                      return LemonNetworkImage(
                        imageUrl: chain?.logoUrl ?? '',
                        width: 20.w,
                        height: 20.w,
                        borderRadius: BorderRadius.circular(20.r),
                        placeholder: const SizedBox.shrink(),
                      );
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(width: Spacing.extraSmall),
                  itemCount: price.supportedNetworks.length,
                ),
              ),
            ],
            if (isStakingTicket || isWhitelistExclusive)
              Padding(
                padding: EdgeInsets.only(top: Spacing.xSmall),
                child: Wrap(
                  spacing: Spacing.xSmall,
                  children: [
                    if (isStakingTicket)
                      LemonOutlineButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.superExtraSmall,
                          vertical: 2.w,
                        ),
                        label: t.event.eventBuyTickets.stakingTicket,
                        backgroundColor: LemonColor.white18,
                        textColor: colorScheme.onPrimary,
                        borderColor: colorScheme.outlineVariant,
                      ),
                    if (isWhitelistExclusive)
                      LemonOutlineButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.superExtraSmall,
                          vertical: 2.w,
                        ),
                        label: t.event.eventBuyTickets.whileListedTicket,
                        backgroundColor: LemonColor.white18,
                        textColor: colorScheme.onPrimary,
                        borderColor: colorScheme.outlineVariant,
                      ),
                  ],
                ),
              ),
          ],
        ),
        TicketCounter(
          count: count,
          onDecrease: onDecrease,
          onIncrease: onIncrease,
          disabled: disabled,
          onPressDisabled: () {
            SnackBarUtils.showError(
              title: t.common.error.label,
              message: t.event.eventBuyTickets.multipleTicketsError,
            );
          },
        ),
      ],
    );
  }
}
