import 'package:app/core/application/payment/claim_relay_payment_bloc/claim_relay_payment_bloc.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_currency.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/web3/entities/chain.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/dotted_line/dotted_line.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/service/web3/lemonade_relay/lemonade_relay_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart' as web3modal;

class ClaimbleRelayPayment {
  final BigInt amount;
  final ERC20Token token;

  ClaimbleRelayPayment({
    required this.amount,
    required this.token,
  });
}

class ClaimPaymentByNetworkGroup extends StatefulWidget {
  final Event event;
  final Chain chain;
  final List<EventCurrency> currencies;
  const ClaimPaymentByNetworkGroup({
    super.key,
    required this.event,
    required this.chain,
    required this.currencies,
  });

  @override
  State<ClaimPaymentByNetworkGroup> createState() =>
      _ClaimPaymentByNetworkGroupState();
}

class _ClaimPaymentByNetworkGroupState
    extends State<ClaimPaymentByNetworkGroup> {
  bool isClaiming = false;

  PaymentAccount? get targetPaymentAccount {
    return widget.event.paymentAccountsExpanded?.firstWhereOrNull(
      (account) =>
          account.accountInfo?.network == widget.chain.chainId &&
          account.type == PaymentAccountType.ethereumRelay,
    );
  }

  Future<void> claimSplit(List<ClaimbleRelayPayment> claimablePayments) async {
    final tokens = claimablePayments
        .where((item) => item.amount != BigInt.zero)
        .map(
          (e) => e.token,
        )
        .toList();
    context.read<ClaimRelayPaymentBloc>().add(
          ClaimRelayPaymentEvent.claim(
            chain: widget.chain,
            tokens: tokens,
            paymentSplitterContractAddress:
                targetPaymentAccount?.accountInfo?.paymentSplitterContract ??
                    '',
            connectedWalletAddress:
                getIt<WalletConnectService>().w3mService.session?.address ?? '',
          ),
        );
  }

  Future<List<ClaimbleRelayPayment>> getClaimablePayments() async {
    final userWalletAddress = targetPaymentAccount?.accountInfo?.address ?? '';
    final tokens = widget.currencies
        .map((item) {
          final targetToken = widget.chain.tokens?.firstWhereOrNull(
            (token) => token.symbol == item.currency,
          );
          return targetToken;
        })
        .whereType<ERC20Token>()
        .toList();
    final amounts = (await LemonadeRelayUtils.getClaimables(
      tokens: tokens,
      chain: widget.chain,
      paymentSplitterContractAddress:
          targetPaymentAccount?.accountInfo?.paymentSplitterContract ?? '',
      userWalletAddress: userWalletAddress,
    ))
        .fold((l) => [] as List<BigInt>, (r) => r);

    final payments = tokens
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          return ClaimbleRelayPayment(
            amount: amounts[index],
            token: entry.value,
          );
        })
        .where((element) => element.amount != BigInt.zero)
        .toList();
    return payments;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocListener<ClaimRelayPaymentBloc, ClaimRelayPaymentState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          success: (txHash, chain) {
            setState(() {});
          },
        );
      },
      child: FutureBuilder(
        future: getClaimablePayments(),
        builder: (context, snapshot) {
          final claimablePayments = snapshot.data ?? [];
          final isClaimable = claimablePayments.isNotEmpty;
          final shouldDisplayBody = claimablePayments.isNotEmpty ||
              (snapshot.connectionState == ConnectionState.waiting);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(Spacing.small),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: LemonColor.atomicBlack,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(LemonRadius.medium),
                    topRight: Radius.circular(LemonRadius.medium),
                    bottomLeft: shouldDisplayBody
                        ? Radius.zero
                        : Radius.circular(LemonRadius.medium),
                    bottomRight: shouldDisplayBody
                        ? Radius.zero
                        : Radius.circular(LemonRadius.medium),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: Sizing.medium,
                      height: Sizing.medium,
                      decoration: ShapeDecoration(
                        color: LemonColor.chineseBlack,
                        shape: const CircleBorder(),
                      ),
                      child: Center(
                        child: LemonNetworkImage(
                          imageUrl: widget.chain.logoUrl ?? '',
                          width: Sizing.mSmall,
                          height: Sizing.mSmall,
                          borderRadius: BorderRadius.circular(Sizing.medium),
                        ),
                      ),
                    ),
                    SizedBox(width: Spacing.xSmall),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.chain.name ?? '',
                          style: Typo.medium.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        if (isClaimable)
                          Text(
                            t.event.relayPayment.claimSplit.pendingClaims,
                            style: Typo.small.copyWith(
                              color: LemonColor.malachiteGreen,
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    if (claimablePayments.isEmpty &&
                        snapshot.connectionState != ConnectionState.waiting)
                      InkWell(
                        onTap: () {
                          setState(() {});
                        },
                        child: Container(
                          width: Sizing.medium,
                          height: Sizing.medium,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.outline,
                            ),
                          ),
                          child: Center(
                            child: Assets.icons.icReload.svg(),
                          ),
                        ),
                      ),
                    if (isClaimable)
                      SizedBox(
                        height: Sizing.medium,
                        child: LinearGradientButton.primaryButton(
                          loadingWhen: isClaiming,
                          label: t.common.actions.claim,
                          onTap: () {
                            if (isClaiming) return;
                            claimSplit(claimablePayments);
                          },
                          textStyle: Typo.small.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (isClaimable ||
                  (snapshot.connectionState == ConnectionState.waiting))
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    color: LemonColor.chineseBlack,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(LemonRadius.medium),
                      bottomRight: Radius.circular(LemonRadius.medium),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          claimablePayments.isEmpty)
                        Loading.defaultLoading(context),
                      for (final item in claimablePayments.asMap().entries)
                        _ClaimableItem(
                          isLast: item.key == claimablePayments.length - 1,
                          claimableRelayPayment: item.value,
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

class _ClaimableItem extends StatelessWidget {
  final ClaimbleRelayPayment claimableRelayPayment;
  final bool isLast;
  const _ClaimableItem({
    required this.isLast,
    required this.claimableRelayPayment,
  });

  @override
  Widget build(BuildContext context) {
    final targetToken = claimableRelayPayment.token;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : Spacing.xSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LemonNetworkImage(
            imageUrl: targetToken.logoUrl ?? '',
            width: Sizing.mSmall,
            height: Sizing.mSmall,
            borderRadius: BorderRadius.circular(Sizing.medium),
            placeholder: Container(
              width: Sizing.mSmall,
              height: Sizing.mSmall,
              decoration: ShapeDecoration(
                color: LemonColor.atomicBlack,
                shape: const CircleBorder(),
              ),
            ),
          ),
          SizedBox(width: Spacing.extraSmall),
          Text(
            targetToken.symbol ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          SizedBox(
            width: Spacing.superExtraSmall,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10.w),
              child: DottedLine(
                dashColor: colorScheme.outline,
              ),
            ),
          ),
          SizedBox(
            width: Spacing.superExtraSmall,
          ),
          Text(
            Web3Utils.formatCryptoCurrency(
              claimableRelayPayment.amount,
              currency: targetToken.symbol ?? '',
              decimals: targetToken.decimals?.toInt() ?? 18,
            ),
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
