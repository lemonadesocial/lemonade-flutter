import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/event/event_provider_bloc/event_provider_bloc.dart';
import 'package:app/core/application/wallet/sign_wallet_bloc/sign_wallet_bloc.dart';
import 'package:app/core/application/wallet/wallet_bloc/wallet_bloc.dart';
import 'package:app/core/domain/web3/entities/application_blockchain_platform.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/wallet/wallet_session_address_extension.dart';
import 'package:app/core/utils/user_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app_theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RSVPVerifyWalletForm extends StatelessWidget {
  const RSVPVerifyWalletForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventProviderBloc>().event;
    final ethereumPlatform = event.rsvpWalletPlatforms?.firstWhereOrNull(
      (item) => item.platform == Enum$BlockchainPlatform.ethereum,
    );
    return Column(
      children: [
        if (ethereumPlatform != null) ...[
          EthereumWalletVerificationWidget(
            rsvpPlatform: ethereumPlatform,
          ),
          SizedBox(height: Spacing.smMedium),
        ],
      ],
    );
  }
}

class EthereumWalletVerificationWidget extends StatelessWidget {
  final ApplicationBlockchainPlatform? rsvpPlatform;
  const EthereumWalletVerificationWidget({
    super.key,
    required this.rsvpPlatform,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final t = Translations.of(context);
    final userProfile = context.watch<AuthBloc>().state.maybeWhen(
          authenticated: (userProfile) => userProfile,
          orElse: () => null,
        );
    final signEthereumWalletBlocState = context.watch<SignWalletBloc>().state;
    final verifiedWallets = userProfile?.walletsNew;
    final isRequired = rsvpPlatform?.isRequired == true;
    final verifiedEthereumAddresses = verifiedWallets?['ethereum'];
    final isVerified = UserUtils.isWalletVerified(
          userProfile,
          platform: Enum$BlockchainPlatform.ethereum,
        ) ||
        signEthereumWalletBlocState is SignWalletStateSuccess;

    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        final isWalletConnected = state.activeSession != null;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: t.event.rsvpWeb3Indetity.yourEthereumAddress,
                    style: appText.md,
                  ),
                  if (isRequired)
                    TextSpan(
                      text: " *",
                      style: appText.md.copyWith(
                        color: appColors.textError,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: Spacing.xSmall),
            if (!isWalletConnected && !isVerified)
              ConnectWalletButton(
                builder: (onPress, connectButtonState) {
                  return FittedBox(
                    child: LemonOutlineButton(
                      height: 50.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: Spacing.s4,
                      ),
                      leading: ThemeSvgIcon(
                        builder: (filter) => Assets.icons.icCurrencyEth.svg(
                          colorFilter: filter,
                        ),
                        color: appColors.textPrimary,
                      ),
                      onTap: () => onPress.call(context),
                      label: t.common.actions.connectWallet,
                      radius: BorderRadius.circular(LemonRadius.md),
                      backgroundColor: appColors.cardBg,
                      borderColor: appColors.pageDivider,
                      textColor: appColors.textPrimary,
                    ),
                  );
                },
              ),
            if (isVerified || (isWalletConnected && !isVerified))
              FittedBox(
                child: LemonOutlineButton(
                  height: 50.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.s4,
                  ),
                  leading: ThemeSvgIcon(
                    builder: (filter) => Assets.icons.icCurrencyEth.svg(
                      colorFilter: filter,
                    ),
                    color: appColors.textPrimary,
                  ),
                  onTap: () {
                    if (isVerified) {
                      return;
                    }
                    context.read<SignWalletBloc>().add(
                          SignWalletEvent.sign(
                            wallet: state.activeSession?.address ?? '',
                          ),
                        );
                  },
                  label: isVerified
                      ? t.event.eventBuyTickets.verifiedWithWallet(
                          address: Web3Utils.formatIdentifier(
                            verifiedEthereumAddresses?.firstWhereOrNull(
                                  (element) =>
                                      element != userProfile?.walletCustodial,
                                ) ??
                                state.activeSession?.address ??
                                '',
                          ),
                        )
                      : t.event.eventBuyTickets.verifyWithWallet,
                  radius: BorderRadius.circular(LemonRadius.md),
                  backgroundColor: appColors.cardBg,
                  borderColor: appColors.pageDivider,
                  textColor: appColors.textPrimary,
                ),
              ),
          ],
        );
      },
    );
  }
}
