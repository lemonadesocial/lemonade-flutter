import 'package:app/core/application/event_tickets/calculate_event_tickets_pricing_bloc/calculate_event_tickets_pricing_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/presentation/widgets/animation/circular_animation_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class WalletSignaturePendingView extends StatelessWidget {
  final PaymentAccount? selectedPaymentAccount;
  final String? selectedCurrency;
  const WalletSignaturePendingView({
    super.key,
    required this.selectedPaymentAccount,
    required this.selectedCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final walletAddress =
        getIt<WalletConnectService>().w3mService.session?.address ?? '';
    return BlocBuilder<CalculateEventTicketPricingBloc,
        CalculateEventTicketPricingState>(
      builder: (context, state) {
        final pricingInfo = state.maybeWhen(
          orElse: () => null,
          success: (pricingInfo, isFree) => pricingInfo,
        );
        final currencyInfo = PaymentUtils.getCurrencyInfo(
          selectedPaymentAccount,
          currency: selectedCurrency ?? '',
        );
        final amountText = Web3Utils.formatCryptoCurrency(
          pricingInfo?.cryptoTotal ?? BigInt.zero,
          currency: selectedCurrency ?? '',
          decimals: currencyInfo?.decimals ?? 2,
        );

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              const Spacer(),
              const Spacer(),
              CircularAnimationWidget(
                icon: Assets.icons.icWalletDarkGradient.svg(),
              ),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.event.eventBuyTickets.signaturePending,
                    style: Typo.extraLarge.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontFamily: FontFamily.nohemiVariable,
                    ),
                  ),
                  SizedBox(height: Spacing.superExtraSmall),
                  Text(
                    t.event.eventBuyTickets.signaturePendingDescription(
                      walletAddress: Web3Utils.formatIdentifier(walletAddress),
                      amount: amountText,
                    ),
                    textAlign: TextAlign.center,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
