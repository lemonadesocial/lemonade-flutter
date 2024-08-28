import 'package:app/core/domain/event/entities/event_tickets_pricing_info.dart';
import 'package:app/core/presentation/widgets/common/slide_to_act/slide_to_act.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/number_utils.dart';
import 'package:app/core/utils/payment_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class EventOrderSlideToPay extends StatelessWidget {
  const EventOrderSlideToPay({
    super.key,
    required this.onSlideToPay,
    required this.slideActionKey,
    required this.selectedCurrency,
    required this.selectedNetwork,
    this.pricingInfo,
  });

  final Function() onSlideToPay;
  final EventTicketsPricingInfo? pricingInfo;
  final String selectedCurrency;
  final String? selectedNetwork;
  final GlobalKey<SlideActionState> slideActionKey;

  BigInt get _totalCryptoAmount {
    return (pricingInfo?.cryptoTotal ?? BigInt.zero) +
        // add fee if available for EthereumRelay
        (pricingInfo?.paymentAccounts?.firstOrNull?.cryptoFee ?? BigInt.zero);
  }

  double get _totalFiatAmount {
    return (pricingInfo?.fiatTotal ?? 0) +
        (pricingInfo?.paymentAccounts?.firstOrNull?.fiatFee ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final currencyInfo =
        PaymentUtils.getCurrencyInfo(pricingInfo, currency: selectedCurrency);

    final amountText = selectedNetwork?.isNotEmpty == true
        ? Web3Utils.formatCryptoCurrency(
            _totalCryptoAmount,
            currency: selectedCurrency,
            decimals: currencyInfo?.decimals ?? 2,
          )
        : NumberUtils.formatCurrency(
            amount: _totalFiatAmount,
            currency: selectedCurrency,
            attemptedDecimals: currencyInfo?.decimals ?? 2,
          );

    return SizedBox(
      height: 60.w,
      child: SlideAction(
        key: slideActionKey,
        onSubmit: () async {
          onSlideToPay();
        },
        text: '${t.event.eventPayment.slideToPay} $amountText',
        textStyle: Typo.medium.copyWith(
          color: LemonColor.paleViolet,
          fontWeight: FontWeight.w600,
          fontFamily: FontFamily.nohemiVariable,
        ),
        outerColor: colorScheme.background,
        sliderButtonIcon: ThemeSvgIcon(
          color: colorScheme.primary.withOpacity(0.18),
          builder: (filter) => Assets.icons.icRoundDoubleArrow.svg(
            colorFilter: filter,
            width: Sizing.small,
            height: Sizing.small,
          ),
        ),
      ),
    );
  }
}
