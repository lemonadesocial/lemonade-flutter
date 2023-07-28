import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/dpos/common/dropdown_item_dpo.dart';
import 'package:app/core/presentation/widgets/floating_frosted_glass_dropdown_widget.dart';
import 'package:app/core/presentation/widgets/lemon_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/wallet_connect/wallet_connect_service.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class ConnectWalletButton extends StatelessWidget {
  const ConnectWalletButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return authState.maybeWhen(
          authenticated: (authSession) {
            return _Button();
          },
          orElse: () => SizedBox.shrink(),
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;

    String getWalletAddress(SessionData sessionData) {
      final sessionAccount = sessionData.namespaces.entries.first.value.accounts.first;
      return NamespaceUtils.getAccount(sessionAccount);
    }

    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, walletState) {
        final activeSession = walletState.activeSession;
        if (activeSession == null) {
          return LemonButton(
            onTap: () {
              context.read<WalletBloc>().add(WalletEventConnectWallet(
                    walletApp: SupportedWalletApp.metamask,
                  ));
            },
            label: t.common.actions.connect,
            icon: ThemeSvgIcon(
              color: onSurfaceColor,
              builder: (filter) => Assets.icons.icWallet.svg(colorFilter: filter),
            ),
          );
        }

        final walletAddress = getWalletAddress(activeSession);

        return FloatingFrostedGlassDropdown(
          items: [
            DropdownItemDpo(label: "Sign your wallet"),
          ],
          offset: Offset(0, Spacing.extraSmall),
          onItemPressed: (item) {
            context.read<WalletBloc>().add(WalletEvent.updateUserWallet(
                  wallet: walletAddress,
                ));
          },
          child: LemonButton(
            label: Web3Utils.formatIdentifier(
              walletAddress,
              length: 3,
            ),
            icon: ThemeSvgIcon(
              color: onSurfaceColor,
              builder: (filter) => Assets.icons.icWallet.svg(colorFilter: filter),
            ),
          ),
        );
      },
    );
  }
}
