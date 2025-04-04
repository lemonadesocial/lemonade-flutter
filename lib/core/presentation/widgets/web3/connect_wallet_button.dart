import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ConnectWalletButton extends StatelessWidget {
  final Function(
    Function(BuildContext context) onPressConnect,
    ConnectButtonState state,
  )? builder;

  const ConnectWalletButton({
    super.key,
    this.builder,
  });

  void _onConnectPressed(BuildContext context) {
    final w3mService = getIt<WalletConnectService>().w3mService;
    w3mService?.openModalView();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final w3mService = getIt<WalletConnectService>().w3mService;
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, walletState) {
        final connectButtonState = walletState.state;
        final connecting = connectButtonState == ConnectButtonState.connecting;
        final disabled = connectButtonState == ConnectButtonState.disabled;

        if (builder != null) {
          return builder?.call(_onConnectPressed, connectButtonState);
        }

        return LinearGradientButton.primaryButton(
          onTap: () {
            if (disabled) {
              return;
            }
            _onConnectPressed(context);
          },
          loadingWhen: connecting || w3mService?.status.isLoading == true,
          label: t.event.eventCryptoPayment.connectWallet,
        );
      },
    );
  }
}
