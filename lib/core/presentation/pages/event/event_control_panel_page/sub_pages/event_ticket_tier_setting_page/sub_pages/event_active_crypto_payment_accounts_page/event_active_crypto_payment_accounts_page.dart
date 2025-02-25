import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/sub_pages/event_setup_direct_crypto_payment_account_page/event_setup_direct_crypto_payment_account_page.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_ticket_tier_setting_page/widgets/get_chains_list_builder.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
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
    extends State<EventActiveCryptoPaymentAccountsPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: LemonAppBar(
        title: t.event.ticketTierSetting.activeNetworks,
      ),
      body: BlocBuilder<GetEventDetailBloc, GetEventDetailState>(
        builder: (context, state) {
          final directCryptoPaymentAccounts = state.maybeWhen(
            orElse: () => <PaymentAccount>[],
            fetched: (event) =>
                (event.paymentAccountsExpanded ?? <PaymentAccount>[])
                    .where(
                      (element) =>
                          element.type == PaymentAccountType.ethereumRelay,
                    )
                    .toList(),
          );
          return GetChainsListBuilder(
            builder: (context, chains) => _ActiveNetworks(
              chains: chains,
              getActivatedPaymentAccount: (chain) {
                return directCryptoPaymentAccounts.firstWhereOrNull(
                  (item) => item.accountInfo?.network == chain.chainId,
                );
              },
              onTap: (chain) async {
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
          );
        },
      ),
    );
  }
}

class _ActiveNetworks extends StatelessWidget {
  final List<Chain> chains;
  final PaymentAccount? Function(Chain chain) getActivatedPaymentAccount;
  final Function(Chain chain) onTap;
  const _ActiveNetworks({
    required this.chains,
    required this.getActivatedPaymentAccount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              itemCount: chains.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: Spacing.xSmall),
              itemBuilder: (context, index) {
                final chain = chains[index];
                final activatedPaymentAccount =
                    getActivatedPaymentAccount(chain);
                return InkWell(
                  onTap: () => onTap(chain),
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
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${chain.name} ',
                                ),
                                TextSpan(
                                  text:
                                      ' ${Web3Utils.formatIdentifier(activatedPaymentAccount?.accountInfo?.address ?? '')}',
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
}
