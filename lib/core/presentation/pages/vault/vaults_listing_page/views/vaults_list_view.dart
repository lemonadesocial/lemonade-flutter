import 'package:app/core/application/payment/get_payment_accounts_bloc/get_payment_accounts_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/input/get_payment_accounts_input/get_payment_accounts_input.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/domain/vault/vault_enums.dart';
import 'package:app/core/presentation/pages/vault/vaults_listing_page/views/add_vault_bottomsheet.dart';
import 'package:app/core/presentation/pages/vault/vaults_listing_page/widgets/add_vault_button.dart';
import 'package:app/core/presentation/pages/vault/vaults_listing_page/widgets/vault_item.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VaultsListView extends StatelessWidget {
  final VaultType vaultType;
  final List<PaymentAccount> vaults;

  const VaultsListView({
    super.key,
    required this.vaultType,
    required this.vaults,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    if (vaults.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            EmptyList(
              emptyText: t.vault.emptyVault,
            ),
            const Spacer(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Spacing.smMedium),
                child: LinearGradientButton(
                  onTap: () {
                    BottomSheetUtils.showSnapBottomSheet(
                      context,
                      builder: (context) => const AddVaultBottomSheet(),
                    );
                  },
                  height: 42.w,
                  label: t.vault.actions.createVault,
                  mode: GradientButtonMode.lavenderMode,
                  radius: BorderRadius.circular(
                    LemonRadius.small * 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<GetPaymentAccountsBloc>().add(
              GetPaymentAccountsEvent.fetch(
                input: GetPaymentAccountsInput(
                  type: PaymentAccountType.ethereum,
                  provider: PaymentProvider.safe,
                ),
              ),
            );
      },
      child: ListView.separated(
        padding: EdgeInsets.all(Spacing.smMedium),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AddVaultButton(
              onPressAdd: () => BottomSheetUtils.showSnapBottomSheet(
                context,
                builder: (context) => const AddVaultBottomSheet(),
              ),
            );
          }
          return VaultItem(
            vault: vaults[index - 1],
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: Spacing.xSmall),
        itemCount: vaults.length + 1,
      ),
    );
  }
}
