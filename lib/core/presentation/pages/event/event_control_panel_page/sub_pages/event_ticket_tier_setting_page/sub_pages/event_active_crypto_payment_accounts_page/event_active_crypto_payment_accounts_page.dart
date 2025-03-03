import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_setup_direct_crypto_payment_account_page/event_setup_direct_crypto_payment_account_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_setup_stake_crypto_payment_account_page/event_setup_stake_crypto_payment_account_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/widgets/get_chains_list_builder.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/service/web3/stake/lemonade_stake_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

@RoutePage()
class EventActiveCryptoPaymentAccountsPage extends StatefulWidget {
  const EventActiveCryptoPaymentAccountsPage({super.key});

  @override
  State<EventActiveCryptoPaymentAccountsPage> createState() =>
      _EventActiveCryptoPaymentAccountsPageState();
}

class _EventActiveCryptoPaymentAccountsPageState
    extends State<EventActiveCryptoPaymentAccountsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _tabController.index != _currentTabIndex) {
        setState(() {
          _currentTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.ticketTierSetting.activeNetworks,
      ),
      body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
        builder: (context, state) {
          final paymentAccounts = state.maybeWhen(
            orElse: () => <PaymentAccount>[],
            fetched: (event) =>
                event.paymentAccountsExpanded ?? <PaymentAccount>[],
          );

          final directCryptoPaymentAccounts = paymentAccounts
              .where(
                (element) => element.type == PaymentAccountType.ethereumRelay,
              )
              .toList();

          final stakeCryptoPaymentAccounts = paymentAccounts
              .where(
                (element) => element.type == PaymentAccountType.ethereumStake,
              )
              .toList();

          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(Spacing.small),
                height: Sizing.large,
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  borderRadius: BorderRadius.circular(LemonRadius.small),
                  border: Border.all(
                    color: colorScheme.outline,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  padding: EdgeInsets.symmetric(
                    vertical: Spacing.superExtraSmall,
                    horizontal: 0,
                  ),
                  indicatorWeight: 0,
                  labelPadding: EdgeInsets.all(Spacing.superExtraSmall),
                  indicatorPadding: EdgeInsets.zero,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      LemonRadius.extraSmall,
                    ),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                    ),
                    color: LemonColor.chineseBlack,
                  ),
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            t.event.ticketTierSetting.direct,
                            style: Typo.medium.copyWith(
                              color: _tabController.index == 0
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            t.event.ticketTierSetting.staking,
                            style: Typo.medium.copyWith(
                              color: _tabController.index == 1
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Direct Crypto Tab
                    GetChainsListBuilder(
                      builder: (context, chains) => _ActiveNetworks(
                        chains: chains,
                        getActivatedPaymentAccount: (chain) {
                          return directCryptoPaymentAccounts.firstWhereOrNull(
                            (item) =>
                                item.accountInfo?.network == chain.chainId,
                          );
                        },
                        onTap: (chain, activatedPaymentAccount) async {
                          await showCupertinoModalBottomSheet<PaymentAccount?>(
                            context: context,
                            backgroundColor: LemonColor.atomicBlack,
                            barrierColor: Colors.black.withOpacity(0.5),
                            builder: (context) =>
                                EventSetupDirectCryptoPaymentAccountPage(
                              chain: chain,
                            ),
                          );
                        },
                      ),
                    ),

                    // Stake Crypto Tab
                    GetChainsListBuilder(
                      builder: (context, chains) => _ActiveNetworks(
                        chains: chains,
                        getActivatedPaymentAccount: (chain) {
                          return stakeCryptoPaymentAccounts.firstWhereOrNull(
                            (item) =>
                                item.accountInfo?.network == chain.chainId,
                          );
                        },
                        onTap: (chain, activatedPaymentAccount) async {
                          await showCupertinoModalBottomSheet<PaymentAccount?>(
                            context: context,
                            backgroundColor: LemonColor.atomicBlack,
                            barrierColor: Colors.black.withOpacity(0.5),
                            builder: (context) =>
                                EventSetupStakeCryptoPaymentAccountPage(
                              chain: chain,
                              activatedPaymentAccount: activatedPaymentAccount,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ActiveNetworks extends StatelessWidget {
  final List<Chain> chains;
  final PaymentAccount? Function(Chain chain) getActivatedPaymentAccount;
  final Function(Chain chain, PaymentAccount? paymentAccount) onTap;
  const _ActiveNetworks({
    required this.chains,
    required this.getActivatedPaymentAccount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    // Sort chains - activated networks first
    final sortedChains = [...chains];
    sortedChains.sort((a, b) {
      final aActivated = getActivatedPaymentAccount(a) != null;
      final bActivated = getActivatedPaymentAccount(b) != null;

      // If a is activated and b is not, a comes first
      if (aActivated && !bActivated) return -1;
      // If b is activated and a is not, b comes first
      if (!aActivated && bActivated) return 1;
      // Otherwise, maintain original order
      return 0;
    });

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              itemCount: sortedChains.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: Spacing.xSmall),
              itemBuilder: (context, index) {
                final chain = sortedChains[index];
                final activatedPaymentAccount =
                    getActivatedPaymentAccount(chain);
                return InkWell(
                  onTap: () => onTap(chain, activatedPaymentAccount),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Spacing.small,
                      vertical: Spacing.small,
                    ),
                    decoration: BoxDecoration(
                      color: activatedPaymentAccount != null
                          ? colorScheme.onPrimary.withOpacity(0.06)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(LemonRadius.small),
                      border: Border.all(
                        color: activatedPaymentAccount != null
                            ? Colors.transparent
                            : colorScheme.outline,
                      ),
                    ),
                    child: Row(
                      children: [
                        if (chain.logoUrl != null) ...[
                          LemonNetworkImage(
                            imageUrl: chain.logoUrl ?? '',
                            width: Sizing.xSmall,
                            height: Sizing.xSmall,
                          ),
                          SizedBox(width: Spacing.xSmall),
                        ],
                        Expanded(
                          child: FutureBuilder<String>(
                            future: _getDisplayText(
                              account: activatedPaymentAccount,
                              chain: chain,
                            ),
                            builder: (context, snapshot) {
                              final displayText = snapshot.data ?? '';
                              return Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${chain.name} ',
                                    ),
                                    if (snapshot.hasData)
                                      TextSpan(
                                        text: displayText,
                                        style: Typo.small.copyWith(
                                          color: colorScheme.onSecondary,
                                        ),
                                      ),
                                  ],
                                ),
                                style: Typo.medium.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ),
                        if (activatedPaymentAccount == null) ...[
                          Text(
                            t.event.ticketTierSetting.activate,
                            style: Typo.medium.copyWith(
                              color: LemonColor.paleViolet,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _getDisplayText({
    required Chain chain,
    required PaymentAccount? account,
  }) async {
    if (account == null) return '';

    if (account.type == PaymentAccountType.ethereumRelay) {
      return ' ${Web3Utils.formatIdentifier(account.accountInfo?.address ?? '')}';
    } else if (account.type == PaymentAccountType.ethereumStake) {
      final payoutAddress = await LemonadeStakeUtils.getPayoutAddress(
        chain: chain,
        configId: account.accountInfo?.configId ?? '',
      );
      return ' ${Web3Utils.formatIdentifier(payoutAddress)}';
    }
    return '';
  }
}
