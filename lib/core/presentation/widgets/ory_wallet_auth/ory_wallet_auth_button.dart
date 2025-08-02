import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/gen/assets.gen.dart';

import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';

class OryWalletAuthButton extends StatefulWidget {
  const OryWalletAuthButton({
    super.key,
    required this.onStartLogin,
  });

  final VoidCallback onStartLogin;

  @override
  State<OryWalletAuthButton> createState() => _OryWalletAuthButtonState();
}

class _OryWalletAuthButtonState extends State<OryWalletAuthButton> {
  bool _walletButtonTapped = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state.activeSession != null && _walletButtonTapped) {
          widget.onStartLogin();
          _walletButtonTapped = false;
        }
      },
      builder: (context, state) {
        final isConnected = state.activeSession != null;
        if (!isConnected) {
          return ConnectWalletButton(
            builder: (onConnectPressed, connectButtonState) {
              return _Button(
                onTap: () async {
                  _walletButtonTapped = true;
                  onConnectPressed(context);
                },
              );
            },
          );
        }
        return _Button(
          onTap: () async {
            widget.onStartLogin();
          },
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onTap,
  });
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Spacing.s3),
        decoration: BoxDecoration(
          color: appColors.buttonTertiaryBg,
          borderRadius: BorderRadius.circular(LemonRadius.full),
        ),
        child: Center(
          child: Builder(
            builder: (context) {
              return ThemeSvgIcon(
                color: appColors.buttonTertiary,
                builder: (filter) =>
                    Assets.icons.icAccountBalanceWalletOutlineSharp.svg(
                  width: 24,
                  height: 24,
                  colorFilter: filter,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
