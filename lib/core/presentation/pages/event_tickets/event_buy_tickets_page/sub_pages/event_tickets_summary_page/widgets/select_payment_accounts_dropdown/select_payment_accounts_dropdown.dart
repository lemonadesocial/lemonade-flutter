import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/presentation/widgets/lemon_network_image/lemon_network_image.dart';
import 'package:app/core/presentation/widgets/web3/chain/chain_query_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectPaymentAccountsDropdown extends StatelessWidget {
  final List<PaymentAccount> paymentAccounts;
  final PaymentAccount? selectedPaymentAccount;
  final Function(PaymentAccount?) onChanged;
  const SelectPaymentAccountsDropdown({
    super.key,
    required this.paymentAccounts,
    required this.selectedPaymentAccount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.event.eventBuyTickets.network,
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Spacing.xSmall),
          DropdownButtonHideUnderline(
            child: DropdownButton2<PaymentAccount>(
              value: selectedPaymentAccount,
              onChanged: (value) {
                onChanged.call(value);
              },
              customButton: Container(
                padding: EdgeInsets.all(Spacing.small),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  color: LemonColor.atomicBlack,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (selectedPaymentAccount != null)
                      _PaymentAccountItem(
                        paymentAccount: selectedPaymentAccount!,
                      )
                    else
                      Text(
                        t.event.eventBuyTickets.chooseNetwork,
                        style: Typo.medium
                            .copyWith(color: colorScheme.onSecondary),
                      ),
                    if (paymentAccounts.length >= 2)
                      Assets.icons.icDoubleArrowUpDown.svg(
                        color: colorScheme.onSecondary,
                      ),
                  ],
                ),
              ),
              items: paymentAccounts.length < 2
                  ? []
                  : paymentAccounts
                      .map(
                        (paymentAccount) => DropdownMenuItem<PaymentAccount>(
                          value: paymentAccount,
                          child: _PaymentAccountItem(
                            paymentAccount: paymentAccount,
                          ),
                        ),
                      )
                      .toList(),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.small),
                  color: LemonColor.atomicBlack,
                ),
                offset: Offset(0, -Spacing.superExtraSmall),
              ),
              menuItemStyleData: const MenuItemStyleData(
                overlayColor: MaterialStatePropertyAll(
                  LemonColor.darkBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentAccountItem extends StatelessWidget {
  final PaymentAccount paymentAccount;
  const _PaymentAccountItem({required this.paymentAccount});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ChainQuery(
      chainId: paymentAccount.accountInfo?.network ?? '',
      builder: (
        chain, {
        required bool isLoading,
      }) =>
          Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (chain?.logoUrl?.isNotEmpty == true) ...[
            LemonNetworkImage(
              imageUrl: chain?.logoUrl ?? '',
              width: 18.w,
              height: 20.w,
              borderRadius: BorderRadius.circular(18.r),
              placeholder: const SizedBox.shrink(),
            ),
            SizedBox(
              width: Spacing.extraSmall,
            ),
          ],
          Text(
            chain?.name ?? '',
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}