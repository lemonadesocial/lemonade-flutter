import 'package:app/core/presentation/pages/vault/vaults_listing_page/views/vaults_list_view.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VaultsListingPage extends StatelessWidget {
  const VaultsListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: LemonAppBar(
        title: StringUtils.capitalize(
          t.vault.vault(n: 2),
        ),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelStyle: Typo.medium.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: Typo.medium.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              indicatorColor: LemonColor.paleViolet,
              tabs: <Widget>[
                Tab(text: t.vault.vaultType.individual),
                Tab(text: t.vault.vaultType.community),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  VaultsListView(),
                  VaultsListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
