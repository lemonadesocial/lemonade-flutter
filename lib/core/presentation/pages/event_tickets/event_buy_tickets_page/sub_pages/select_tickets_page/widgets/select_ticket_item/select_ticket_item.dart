import 'package:app/core/application/event_tickets/get_event_ticket_types_bloc/get_event_ticket_types_bloc.dart';
import 'package:app/core/application/event_tickets/select_event_tickets_bloc/select_event_tickets_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/entities/event_ticket_types.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/reward/entities/token_reward_setting.dart';
import 'package:app/core/domain/reward/reward_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/select_ticket_item/ticket_token_rewards_list.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/sub_pages/select_tickets_page/widgets/ticket_counter.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/widgets/staking_config_info_widget.dart';
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
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/app_theme/app_theme.dart';

class SelectTicketItem extends StatelessWidget {
  const SelectTicketItem({
    super.key,
    required this.ticketType,
    required this.allTicketTypes,
    required this.event,
    required this.onCountChange,
    this.networkFilter,
  });

  final Event event;
  final List<PurchasableTicketType> allTicketTypes;
  final PurchasableTicketType ticketType;
  final String? networkFilter;
  final Function(int count) onCountChange;

  void add({
    required int newCount,
  }) {
    onCountChange(newCount);
  }

  void minus({
    required int newCount,
  }) {
    onCountChange(newCount);
  }

  bool get isWhitelistExclusive {
    return ticketType.limited == true;
  }

  PaymentAccount? get stakingPaymentAccount {
    return (ticketType.prices ?? [])
        .expand((price) => price.paymentAccountsExpanded ?? <PaymentAccount>[])
        .firstWhereOrNull(
          (element) => element.type == PaymentAccountType.ethereumStake,
        );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    List<EventCurrency> eventCurrencies =
        context.watch<GetEventTicketTypesBloc>().state.maybeWhen(
              orElse: () => [],
              success: (_, currencies) => currencies,
            );
    final selectTicketsBloc = context.watch<SelectEventTicketsBloc>();
    final isLocked =
        ticketType.limited == true && ticketType.whitelisted == false;
    final count = selectTicketsBloc.state.selectedTickets
            .firstWhereOrNull(
              (element) => element.id == ticketType.id,
            )
            ?.count ??
        0;
    final commonPaymentAccounts = selectTicketsBloc.state.commonPaymentAccounts;
    final allPaymentAccountsOfTicketType = (ticketType.prices ?? [])
        .expand((price) => price.paymentAccountsExpanded ?? <PaymentAccount>[])
        .toList();

    // Get all currencies from this ticket type
    final ticketTypeCurrencies =
        ticketType.prices?.map((p) => p.currency).whereType<String>().toSet() ??
            {};

    // Get all currencies from selected ticket types before
    final selectedTicketsCurrencies = selectTicketsBloc.state.selectedTickets
        .map((ticket) => ticket.id)
        .map((id) => allTicketTypes.firstWhere((t) => t.id == id))
        .expand(
          (ticketType) => (ticketType.prices ?? []).map((p) => p.currency),
        )
        .whereType<String>()
        .toSet();

    // Check if there are any common currencies
    final hasCommonCurrencies = selectedTicketsCurrencies.isEmpty ||
        ticketTypeCurrencies
            .any((currency) => selectedTicketsCurrencies.contains(currency));

    // For free ticket, there aren't any payment accounts
    final isFreeTicket = allPaymentAccountsOfTicketType.isEmpty;

    bool enabled = hasCommonCurrencies;

    if (commonPaymentAccounts.isEmpty) {
      // if this is paid ticket and we have selected free tickets before, disable it
      if (selectTicketsBloc.state.selectedTickets.isNotEmpty && !isFreeTicket) {
        enabled = false;
      } else {
        enabled = hasCommonCurrencies;
      }
    } else {
      final newCommonPaymentAccounts = PaymentUtils.getCommonPaymentAccounts(
        accounts1: commonPaymentAccounts,
        accounts2: allPaymentAccountsOfTicketType,
      );
      enabled = newCommonPaymentAccounts.isNotEmpty && hasCommonCurrencies;
    }
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
                color: appColors.textTertiary,
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
      child: Opacity(
        opacity: isLocked ? 0.5 : 1,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: appColors.cardBg,
            borderRadius: BorderRadius.circular(LemonRadius.medium),
            border: Border.all(
              color: appColors.pageDivider,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            ticketType.title ?? '',
                            style: appText.md
                                .copyWith(color: appColors.textSecondary),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: (ticketType.prices ?? [])
                                .toList()
                                .asMap()
                                .entries
                                .expand((entry) {
                              final ticketPrice = entry.value;
                              final isLast = entry.key ==
                                  (ticketType.prices?.length ?? 0) - 1;
                              final decimals =
                                  EventTicketUtils.getEventCurrency(
                                        currencies: eventCurrencies,
                                        currency: ticketPrice.currency,
                                      )?.decimals?.toInt() ??
                                      2;

                              return [
                                _PriceItem(
                                  ticketType: ticketType,
                                  decimals: decimals,
                                  currency: ticketPrice.currency!,
                                  price: ticketPrice,
                                  textColor: entry.key != 0
                                      ? appColors.textTertiary
                                      : appColors.textPrimary,
                                ),
                                if (!isLast &&
                                    (ticketType.prices?.length ?? 0) > 1)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Spacing.superExtraSmall,
                                    ),
                                    child: Text(
                                      t.common.or,
                                      style: appText.md.copyWith(
                                        color: appColors.textTertiary,
                                      ),
                                    ),
                                  ),
                              ];
                            }).toList(),
                          ),
                          if (isWhitelistExclusive ||
                              stakingPaymentAccount != null)
                            Padding(
                              padding: EdgeInsets.only(top: Spacing.xSmall),
                              child: Wrap(
                                spacing: Spacing.xSmall,
                                children: [
                                  if (isWhitelistExclusive)
                                    FittedBox(
                                      child: LemonOutlineButton(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Spacing.superExtraSmall,
                                          vertical: 2.w,
                                        ),
                                        label: t.event.eventBuyTickets
                                            .whileListedTicket,
                                        backgroundColor: LemonColor.white18,
                                        textColor: appColors.textPrimary,
                                        borderColor: appColors.pageDivider,
                                      ),
                                    ),
                                  if (stakingPaymentAccount != null)
                                    FittedBox(
                                      child: LemonOutlineButton(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Spacing.superExtraSmall,
                                          vertical: 2.w,
                                        ),
                                        label: t.event.eventBuyTickets
                                            .stakingTicket,
                                        backgroundColor: LemonColor.white18,
                                        textColor: appColors.textPrimary,
                                        borderColor: appColors.pageDivider,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    TicketCounter(
                      count: count,
                      onIncrease: (newCount) {
                        add(
                          newCount: newCount,
                        );
                      },
                      onDecrease: (newCount) {
                        minus(
                          newCount: newCount,
                        );
                      },
                      disabled: isLocked || !enabled,
                      limit: ticketType.limit,
                      onPressDisabled: () {
                        SnackBarUtils.showError(
                          title: t.common.error.label,
                          message: t.event.eventBuyTickets.multipleTicketsError,
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (ticketType.description != null &&
                  ticketType.description!.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.only(
                    left: Spacing.smMedium,
                    right: Spacing.smMedium,
                    top: Spacing.xSmall,
                  ),
                  child: Text(
                    ticketType.description ?? '',
                    style: appText.sm.copyWith(
                      color: appColors.textTertiary,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
              if (stakingPaymentAccount != null) ...[
                SizedBox(height: Spacing.xSmall),
                Divider(
                  color: appColors.pageDivider,
                ),
                SizedBox(height: Spacing.xSmall),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: StakingConfigInfoWidget(
                    paymentAccount: stakingPaymentAccount,
                  ),
                ),
              ],
              FutureBuilder<Either<Failure, List<TokenRewardSetting>>>(
                future: getIt<RewardRepository>().listTicketTokenRewardSettings(
                  event: event.id ?? '',
                  ticketTypes: [ticketType.id ?? ''],
                ),
                builder: (context, snapshot) {
                  final tokenRewardSettings =
                      snapshot.data?.getOrElse(() => []);
                  if (tokenRewardSettings == null ||
                      tokenRewardSettings.isEmpty == true) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Spacing.xSmall),
                      Divider(
                        color: appColors.pageDivider,
                      ),
                      SizedBox(height: Spacing.xSmall),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Spacing.small,
                        ),
                        child: TicketTokenRewardsList(
                          tokenRewardSettings: tokenRewardSettings,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceItem extends StatelessWidget {
  final String currency;
  final PurchasableTicketType ticketType;
  final EventTicketPrice price;
  final int decimals;
  final Color? textColor;

  const _PriceItem({
    required this.currency,
    required this.ticketType,
    required this.price,
    required this.decimals,
    this.textColor,
  });

  bool get isStakingTicket {
    return price.paymentAccounts?.isNotEmpty == true &&
        (price.paymentAccountsExpanded?.every(
              (element) => element.type == PaymentAccountType.ethereumStake,
            ) ??
            false);
  }

  @override
  Widget build(BuildContext context) {
    final isCryptoCurrency = price.isCrypto;
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          style: appText.md.copyWith(
            color: textColor ?? appColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (price.supportedNetworks.isNotEmpty) ...[
          SizedBox(width: Spacing.xSmall),
          SizedBox(
            height: 20.w,
            child: Wrap(
              spacing: Spacing.extraSmall,
              children: price.supportedNetworks
                  .map(
                    (chainId) => ChainQuery(
                      chainId: chainId,
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
                  )
                  .toList(),
            ),
          ),
        ],
      ],
    );
  }
}
