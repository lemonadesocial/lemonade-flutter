import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/pages/event_tickets/event_buy_tickets_page/widgets/staking_config_info_widget.dart';
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
  final List<PaymentAccount> disabledPaymentAccounts;
  final PaymentAccount? selectedPaymentAccount;
  final Function(PaymentAccount?) onChanged;
  const SelectPaymentAccountsDropdown({
    super.key,
    required this.paymentAccounts,
    required this.disabledPaymentAccounts,
    required this.selectedPaymentAccount,
    required this.onChanged,
  });

  bool get isStakingPaymentAccount {
    return paymentAccounts
        .any((account) => account.type == PaymentAccountType.ethereumStake);
  }

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
                if (value == null) {
                  return;
                }
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
                    Assets.icons.icDoubleArrowUpDown.svg(
                      color: colorScheme.onSecondary,
                    ),
                  ],
                ),
              ),
              items: [
                ...paymentAccounts.map(
                  (paymentAccount) => DropdownMenuItem<PaymentAccount>(
                    value: paymentAccount,
                    child: _PaymentAccountItem(
                      paymentAccount: paymentAccount,
                    ),
                  ),
                ),
                if (disabledPaymentAccounts.isNotEmpty)
                  DropdownMenuItem(
                    value: null,
                    child: Opacity(
                      opacity: 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.event.eventBuyTickets.unavailable,
                            style: Typo.medium.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                          Text(
                            t.event.eventBuyTickets.unavailableDescription,
                            style: Typo.small.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ...disabledPaymentAccounts.map(
                  (paymentAccount) => DropdownMenuItem<PaymentAccount>(
                    value: null,
                    child: Opacity(
                      opacity: 0.5,
                      child: _PaymentAccountItem(
                        paymentAccount: paymentAccount,
                      ),
                    ),
                  ),
                ),
              ],
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(LemonRadius.small),
                  color: LemonColor.atomicBlack,
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                offset: Offset(0, -Spacing.superExtraSmall),
              ),
              menuItemStyleData: const MenuItemStyleData(
                // height: 80,
                overlayColor: MaterialStatePropertyAll(
                  LemonColor.darkBackground,
                ),
              ),
            ),
          ),
          if (isStakingPaymentAccount && selectedPaymentAccount != null) ...[
            SizedBox(height: Spacing.xSmall),
            SizedBox(
              width: double.infinity,
              child: Card(
                color: colorScheme.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(LemonRadius.medium),
                  side: BorderSide(color: colorScheme.outline),
                ),
                child: Padding(
                  padding: EdgeInsets.all(Spacing.small),
                  child: StakingConfigInfoWidget(
                    paymentAccount: selectedPaymentAccount,
                  ),
                ),
              ),
            ),
          ],
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
    final t = Translations.of(context);
    if (paymentAccount.type == PaymentAccountType.digital) {
      return Row(
        children: [
          Assets.icons.icStripe.svg(),
          SizedBox(
            width: Spacing.extraSmall,
          ),
          Text(
            t.event.eventBuyTickets.stripe,
            style: Typo.medium.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
          SizedBox(
            width: Spacing.extraSmall,
          ),
          Text(
            t.event.eventBuyTickets.creditDebit,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      );
    }
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
