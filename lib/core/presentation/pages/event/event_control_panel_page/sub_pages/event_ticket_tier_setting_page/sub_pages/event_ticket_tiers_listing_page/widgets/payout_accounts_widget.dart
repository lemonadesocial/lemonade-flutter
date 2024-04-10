import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/payment/entities/payment_account/payment_account.dart';
import 'package:app/core/domain/payment/payment_enums.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/presentation/widgets/web3/connect_wallet_button.dart';
import 'package:app/core/service/wallet/wallet_connect_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/web3_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class PayoutAccountsWidget extends StatefulWidget {
  const PayoutAccountsWidget({super.key});

  @override
  State<PayoutAccountsWidget> createState() => _PayoutAccountsWidgetState();
}

class _PayoutAccountsWidgetState extends State<PayoutAccountsWidget> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final eventPaymentAccountsExpanded =
        context.watch<GetEventDetailBloc>().state.maybeWhen(
              fetched: (event) => event.paymentAccountsExpanded,
              orElse: () => [] as List<PaymentAccount>,
            );
    final hasStripePaymentAccount = eventPaymentAccountsExpanded!.any(
      (item) => item.provider == PaymentProvider.stripe,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.event.ticketTierSetting.payoutAccounts,
          style: Typo.medium.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: Spacing.xSmall),
        PayoutAccountItem(
          title: t.event.ticketTierSetting.creditDebit,
          subTitle: hasStripePaymentAccount
              ? t.event.ticketTierSetting.selectAccount
              : t.event.ticketTierSetting.connectAccount,
          icon: ThemeSvgIcon(
            color: colorScheme.onSecondary,
            builder: (filter) => Assets.icons.icBank.svg(
              colorFilter: filter,
            ),
          ),
          buttonBuilder: () {
            if (hasStripePaymentAccount) {
              return InkWell(
                onTap: () {},
                child: ThemeSvgIcon(
                  color: colorScheme.onSurfaceVariant,
                  builder: (filter) => Assets.icons.icArrowRight.svg(
                    colorFilter: filter,
                  ),
                ),
              );
            }
            return LinearGradientButton(
              onTap: () => SnackBarUtils.showComingSoon(),
              // TODO:
              // onTap: () => Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const StripeOauthPage(),
              //   ),
              // ),
              height: Sizing.medium,
              radius: BorderRadius.circular(LemonRadius.small * 2),
              label: t.common.actions.connect,
            );
          },
        ),
        SizedBox(height: Spacing.xSmall),
        FutureBuilder<SessionData?>(
          future: getIt<WalletConnectService>().getActiveSession(),
          builder: (context, walletConnectSnapshot) {
            final activeSession = walletConnectSnapshot.data;
            final userWalletAddress =
                getIt<WalletConnectService>().w3mService.address ?? '';
            return PayoutAccountItem(
              title: t.event.ticketTierSetting.crypto,
              subTitle: activeSession != null
                  ? Web3Utils.formatIdentifier(userWalletAddress)
                  : t.common.actions.connectWallet,
              icon: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icWallet.svg(
                  colorFilter: filter,
                ),
              ),
              buttonBuilder: () {
                if (activeSession != null) {
                  return InkWell(
                    onTap: () {},
                    child: ThemeSvgIcon(
                      color: colorScheme.onSurfaceVariant,
                      builder: (filter) => Assets.icons.icArrowRight.svg(
                        colorFilter: filter,
                      ),
                    ),
                  );
                }

                return ConnectWalletButton(
                  builder: (onPressConnect, connectButtonState) =>
                      LinearGradientButton(
                    loadingWhen:
                        connectButtonState == ConnectButtonState.connecting,
                    height: Sizing.medium,
                    radius: BorderRadius.circular(LemonRadius.small * 2),
                    label: t.common.actions.connect,
                    onTap: () => onPressConnect(context),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class PayoutAccountItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget icon;
  final Widget Function()? buttonBuilder;

  const PayoutAccountItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.buttonBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.smMedium),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.small),
      ),
      child: Row(
        children: [
          Container(
            width: Sizing.medium,
            height: Sizing.medium,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(Sizing.medium),
            ),
            child: Center(
              child: icon,
            ),
          ),
          SizedBox(width: Spacing.xSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary.withOpacity(0.87),
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  subTitle,
                  style: Typo.small.copyWith(
                    color: colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (buttonBuilder != null) buttonBuilder!.call(),
        ],
      ),
    );
  }
}
