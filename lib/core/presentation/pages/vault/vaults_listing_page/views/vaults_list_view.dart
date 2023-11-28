import 'package:app/core/presentation/pages/vault/vaults_listing_page/views/add_vault_bottomsheet.dart';
import 'package:app/core/presentation/pages/vault/vaults_listing_page/widgets/add_vault_button.dart';
import 'package:app/core/presentation/pages/vault/vaults_listing_page/widgets/vault_item.dart';
import 'package:app/core/utils/bottomsheet_utils.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class VaultsListView extends StatelessWidget {
  const VaultsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
        return const VaultItem();
      },
      separatorBuilder: (context, index) => SizedBox(height: Spacing.xSmall),
      itemCount: 4,
    );
  }
}
