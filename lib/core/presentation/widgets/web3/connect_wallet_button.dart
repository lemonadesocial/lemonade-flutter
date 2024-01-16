import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/wallet_connect/wallet_connect_popup/wallet_connect_popup.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';

class ConnectWalletButton extends StatelessWidget {
  final Function(SupportedWalletApp walletApp)? onSelect;
  final Function(void Function(BuildContext context) showOptions)? builder;

  const ConnectWalletButton({
    super.key,
    this.onSelect,
    this.builder,
  });

  void showSelectWalletPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (newContext) => WalletConnectPopup(
        onSelect: (walletApp) {
          Navigator.of(newContext).pop();
          onSelect?.call(walletApp);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    if (builder != null) {
      return builder?.call(showSelectWalletPopup);
    }
    return LinearGradientButton(
      onTap: () => showSelectWalletPopup(context),
      height: Sizing.large,
      radius: BorderRadius.circular(LemonRadius.small * 2),
      mode: GradientButtonMode.lavenderMode,
      label: t.event.eventCryptoPayment.connectWallet,
      textStyle: Typo.medium.copyWith(
        fontFamily: FontFamily.nohemiVariable,
        fontWeight: FontWeight.w600,
        color: colorScheme.onPrimary.withOpacity(0.87),
      ),
    );
  }
}
