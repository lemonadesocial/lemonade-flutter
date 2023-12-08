import 'package:app/core/application/payment/get_payment_accounts_bloc/get_payment_accounts_bloc.dart';
import 'package:app/core/application/vault/check_vault_pin_bloc/check_vault_pin_bloc.dart';
import 'package:app/core/domain/vault/vault_enums.dart';
import 'package:app/core/presentation/pages/vault/vaults_listing_page/views/vaults_list_view.dart';
import 'package:app/core/presentation/widgets/app_lock/app_lock.dart';
import 'package:app/core/presentation/widgets/app_lock/lemon_app_lock_page.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VaultsListingPage extends StatelessWidget {
  const VaultsListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = AuthUtils.getUserId(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckVaultPinBloc(userId: userId)
            ..add(
              CheckVaultPinEvent.initialize(),
            ),
        ),
      ],
      child: const VaultsListingPageView(),
    );
  }
}

class VaultsListingPageView extends StatelessWidget {
  const VaultsListingPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocBuilder<CheckVaultPinBloc, CheckVaultPinState>(
      builder: (context, vaultPinState) {
        if (vaultPinState is CheckVaultPinStateChecking) {
          return Scaffold(
            backgroundColor: colorScheme.background,
            body: Center(
              child: Loading.defaultLoading(context),
            ),
          );
        }
        return AppLock(
          theme: Theme.of(context),
          enabled: vaultPinState.maybeWhen(
            orElse: () => false,
            noPin: () => false,
            pinRequired: (_) => true,
          ),
          lockScreen: LemonAppLockPage(
            title: t.vault.createPIN.confirmPIN,
            description: t.vault.createPIN.setPINDescription,
            correctPin: vaultPinState.maybeWhen(
              orElse: () => '',
              pinRequired: (correctPin) => correctPin,
            ),
          ),
          builder: (arg) => Scaffold(
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
                  Expanded(
                    child: BlocBuilder<GetPaymentAccountsBloc,
                        GetPaymentAccountsState>(
                      builder: (context, state) => state.when(
                        initial: () => Loading.defaultLoading(context),
                        loading: () => Loading.defaultLoading(context),
                        failure: () => EmptyList(
                          emptyText: t.common.somethingWrong,
                        ),
                        success: (paymentAccounts) {
                          final individualVaults = paymentAccounts
                              .where(
                                (account) =>
                                    account.accountInfo?.owners?.length == 1,
                              )
                              .toList();
                          final communityVaults = paymentAccounts
                              .where(
                                (account) =>
                                    (account.accountInfo?.owners ?? []).length >
                                    1,
                              )
                              .toList();
                          return TabBarView(
                            children: [
                              VaultsListView(
                                vaultType: VaultType.individual,
                                vaults: individualVaults,
                              ),
                              VaultsListView(
                                vaultType: VaultType.community,
                                vaults: communityVaults,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
