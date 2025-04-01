import 'package:app/core/domain/event/input/ticket_type_input/ticket_type_input.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class TicketTierAddPriceButton extends StatelessWidget {
  final TicketPriceInput? ticketPrice;
  final List<PaymentAccount>? paymentAccounts;
  final String label;
  final VoidCallback onTap;
  final Widget? icon;

  const TicketTierAddPriceButton({
    super.key,
    required this.label,
    required this.onTap,
    this.ticketPrice,
    this.icon,
    this.paymentAccounts,
  });

  int get decimals {
    return paymentAccounts?.firstOrNull?.accountInfo
            ?.currencyMap?[ticketPrice?.currency ?? '']?.decimals ??
        2;
  }

  bool get isCrypto {
    return paymentAccounts
            ?.every((element) => element.type != PaymentAccountType.digital) ??
        false;
  }

  CurrencyTextInputFormatter get currencyFormatter {
    return CurrencyTextInputFormatter.currency(
      symbol: ticketPrice?.currency ?? '',
      decimalDigits: decimals,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        decoration: BoxDecoration(
          color: LemonColor.atomicBlack,
          borderRadius: BorderRadius.circular(LemonRadius.medium),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: Spacing.xSmall),
            ],
            if (ticketPrice == null)
              Expanded(
                child: Text(label),
              ),
            if (ticketPrice != null)
              Expanded(
                child: Builder(
                  builder: (context) {
                    final displayAmount = isCrypto
                        ? Web3Utils.formatCryptoCurrency(
                            BigInt.parse(ticketPrice!.cost),
                            currency: ticketPrice!.currency,
                            decimals: decimals,
                          )
                        : currencyFormatter.formatString(ticketPrice!.cost);
                    return Text(
                      displayAmount,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
              ),
            if (isCrypto)
              Wrap(
                spacing: Spacing.superExtraSmall,
                children: (paymentAccounts ?? []).map((acc) {
                  return ChainQuery(
                    chainId: acc.accountInfo?.network ?? '',
                    builder: (chain, {required bool isLoading}) {
                      return LemonNetworkImage(
                        imageUrl: chain?.logoUrl ?? '',
                        width: Sizing.xSmall,
                        height: Sizing.xSmall,
                        borderRadius: BorderRadius.circular(Sizing.xSmall),
                      );
                    },
                  );
                }).toList(),
              ),
            SizedBox(width: Spacing.xSmall),
            ThemeSvgIcon(
              color: colorScheme.onSecondary,
              builder: (colorFilter) => ticketPrice != null
                  ? Assets.icons.icEdit.svg(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      colorFilter: colorFilter,
                    )
                  : Assets.icons.icArrowRight.svg(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                      colorFilter: colorFilter,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
