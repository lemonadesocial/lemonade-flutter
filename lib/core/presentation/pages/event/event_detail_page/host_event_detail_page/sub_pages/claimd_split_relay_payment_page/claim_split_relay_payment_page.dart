import 'package:app/core/application/payment/claim_relay_payment_bloc/claim_relay_payment_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/event/input/get_event_currencies_input/get_event_currencies_input.dart';
import 'package:app/core/domain/event/repository/event_ticket_repository.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/domain/web3/web3_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/claimd_split_relay_payment_page/widgets/claim_loading_widget.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/claimd_split_relay_payment_page/widgets/claim_payment_by_network_group_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ClaimSplitRelayPaymentPage extends StatelessWidget {
  final Event event;
  const ClaimSplitRelayPaymentPage({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClaimRelayPaymentBloc(),
      child: ClaimSplitRelayPaymentPageView(
        event: event,
      ),
    );
  }
}

class ClaimSplitRelayPaymentPageView extends StatelessWidget {
  final Event event;
  const ClaimSplitRelayPaymentPageView({
    super.key,
    required this.event,
  });

  Future<Map<Chain, List<EventCurrency>>>
      getAllCurrenciesGroupByNetwork() async {
    final chains = (await getIt<Web3Repository>().getChainsList()).fold(
      (l) => [] as List<Chain>,
      (r) => r,
    );

    final currencies = (await getIt<EventTicketRepository>().getEventCurrencies(
      input: GetEventCurrenciesInput(
        id: event.id ?? '',
      ),
    ))
        .fold(
      (l) => [] as List<EventCurrency>,
      (r) => r.where((element) => element.network?.isNotEmpty == true),
    );
    return groupBy<EventCurrency, Chain>(
      currencies,
      (currency) {
        return chains.firstWhereOrNull(
              (chain) => chain.chainId == currency.network,
            ) ??
            Chain();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                return FutureBuilder(
                  future: getAllCurrenciesGroupByNetwork(),
                  builder: (context, snapshot) {
                    final isConnected = state.activeSession != null;
                    return CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: LemonAppBar(),
                        ),
                        SliverPadding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Spacing.small),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.event.relayPayment.claimSplit
                                      .claimSplitTitle,
                                  style: Typo.extraLarge.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: FontFamily.clashDisplay,
                                  ),
                                ),
                                SizedBox(height: Spacing.superExtraSmall),
                                Text(
                                  t.event.relayPayment.claimSplit
                                      .claimSplitDescription,
                                  style: Typo.mediumPlus.copyWith(
                                    color: colorScheme.onSecondary,
                                  ),
                                ),
                                SizedBox(height: Spacing.large),
                              ],
                            ),
                          ),
                        ),
                        if (!isConnected)
                          SliverPadding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Spacing.small),
                            sliver: const SliverToBoxAdapter(
                              child: ConnectWalletButton(),
                            ),
                          ),
                        if (isConnected)
                          SliverPadding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Spacing.small),
                            sliver: Builder(
                              builder: (context) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SliverToBoxAdapter(
                                    child: Center(
                                      child: Loading.defaultLoading(context),
                                    ),
                                  );
                                }

                                if (snapshot.data == null) {
                                  return const SliverToBoxAdapter(
                                    child: Center(
                                      child: EmptyList(),
                                    ),
                                  );
                                }

                                final currenciesByNetwork = snapshot.data
                                    as Map<Chain, List<EventCurrency>>;

                                if (currenciesByNetwork.entries.isEmpty) {
                                  return const SliverToBoxAdapter(
                                    child: Center(
                                      child: EmptyList(),
                                    ),
                                  );
                                }
                                return SliverList.separated(
                                  itemCount: currenciesByNetwork.entries.length,
                                  itemBuilder: (context, index) {
                                    final group = currenciesByNetwork.entries
                                        .toList()[index];
                                    return ClaimPaymentByNetworkGroup(
                                      event: event,
                                      chain: group.key,
                                      currencies: group.value,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: Spacing.xSmall),
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          BlocConsumer<ClaimRelayPaymentBloc, ClaimRelayPaymentState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () => null,
                failure: (txHash, chain, failure) {
                  SnackBarUtils.showError(
                    message: failure?.message ??
                        t.event.relayPayment.claimSplit.claimSplitFailed,
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                waiting: (txHash, chain) {
                  return const ClaimLoadingWidget(
                    state: ClaimState.waiting,
                  );
                },
                success: (txHash, chain) {
                  return ClaimLoadingWidget(
                    state: ClaimState.success,
                    onPressDone: () {
                      context
                          .read<ClaimRelayPaymentBloc>()
                          .add(ClaimRelayPaymentEvent.reset());
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
